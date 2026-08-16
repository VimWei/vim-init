"===================================================
" JsTsFold.vim - expr-based folding for JS/TS/JSX/TSX
" Cached single-pass scanner.
" Inspired by rlue/vim-fold-js (MIT), rewritten to be
" bracket-aware and string/comment/regex-safe.
"
" Rebuild timing:
"   Folds are computed once per buffer by JsTsFold#Refresh()
"   (called on file open and BufWritePost from the ftplugins,
"   or manually via :JsTsFoldRefresh). JsTsFold#Level() only
"   reads the cached table, so editing never triggers a
"   full-file rescan (measured: 3250-line TS opens in ~2s
"   console / ~0.6s GVim; rescan only happens on save).
"
" Strategy:
"   - A declaration heading line (function/class/interface/...)
"     opens a fold only when its line leaves a `{` unmatched
"     (the function body), so default-param `{a:1}` or one-line
"     bodies are handled correctly.
"   - The matching `}` restores the stack top -> line closes.
"   - `<` is treated as a plain operator; `Promise<string>`,
"     `a < b` never open spurious JSX states.
"
" Simplified state machine (perf):
"   - Five modes only: code / string / line_comment / block_comment
"     / regex. Template literals are treated as plain strings, so
"     `${...}` braces inside them are skipped (safe for folding).
"   - Event-driven: match() jumps between significant chars, so
"     ordinary identifier/whitespace runs cost one call.
"   - Byte indexing (l:line[l:i]) is far faster than strcharpart()
"     on Windows (measured ~0.7s vs ~5s on the same scan).
"   - Brace stack stores single chars (d/b/a) instead of dicts.
"   - All regexes are script-scoped variables (inline regex in a
"     function gets recompiled on every call, which is very slow).
"
" Robustness (self-healing):
"   - Single/double-quoted strings and regex literals cannot span
"     lines in JS/TS. If a line ends still inside one, it is treated
"     as a parse error (missing quote/slash) and the scanner resets
"     to code mode, so a single broken line never poisons the rest
"     of the file (template literals and block comments, which may
"     legally span lines, keep their state).
"   - Popping an empty brace stack is a no-op, so stray `}`/`]`
"     cannot shift the depth of unrelated declarations.
"===================================================

" 声明行正则：行首可带 export/declare/abstract/async 前缀，
" 后跟 function/class/interface/type/namespace/module/enum 之一，
" 或 const 常量（对象/数组字面量，如 `const x = [`）。
let s:decl_regex =
      \ '^\s*'
      \ . '\%(export\s\+\%(default\s\+\)\?\|declare\s\+\|abstract\s\+\)*'
      \ . '\%(async\s\+\)\?'
      \ . '\%(function\%(\s\|(\|\*\)\|class\s\|interface\s\|'
      \ . 'type\s\|namespace\s\|module\s\|enum\s\|const\s\+enum\s\|const\s\+\w\+\)'

" 上一个非空白字符属于该集合时，/ 视为正则而非除号
let s:regex_prev = '[([{:;,=!&|?+\-*%^~<>`]'

" 特殊字符（需要逐事件处理）。其余内容由 match() 快进跳过。
let s:code_special = '[{}()<>/"`' . "'" . '$*\\;:,.=!&|?+\-^~\[\]]'

" 正则脚本变量（避免函数内联正则每次调用重新编译）
let s:wordchar_re = '[A-Za-z0-9_$]'
let s:wordstart_re = '[A-Za-z_$]'

" 其后通常紧跟表达式的关键字（影响 / 与正则的判别）
let s:expr_keywords = [
      \ 'return', 'throw', 'typeof', 'case', 'delete', 'new',
      \ 'in', 'of', 'instanceof', 'yield', 'await', 'void',
      \ 'do', 'else'
      \ ]

" foldexpr 入口 -------------------------------------------------------------{{{1
" 仅在缓存已构建时返回；构建由 JsTsFold#Refresh() 触发
" （打开文件、保存文件时），避免每次击键全量重扫大文件。
function! JsTsFold#Level(lnum) abort
  if get(b:, 'js_ts_fold_ready', 0)
    return get(b:js_ts_fold_levels, a:lnum, '=')
  endif
  return '='
endfunction

" 强制重建折叠缓存 ------------------------------------------------{{{1
" 重建后重新设置 foldmethod 以触发当前缓冲区折叠重算。
function! JsTsFold#Refresh() abort
  call JsTsFold#Build()
  let l:fm = &l:foldmethod
  if l:fm !=# 'expr'
    setlocal foldmethod=expr
  else
    setlocal foldmethod=manual
    setlocal foldmethod=expr
  endif
endfunction

" foldtext 入口 -------------------------------------------------------------{{{1
function! JsTsFold#Text() abort
  let l:line = substitute(getline(v:foldstart), '^\s*', '', '')
  let l:line = substitute(l:line, '\s*{$', '', '')
  let l:count = v:foldend - v:foldstart + 1
  return l:line . '  [' . l:count . ' lines]'
endfunction

" 单次全扫描构建每行折叠级别 ------------------------------------------------{{{1
" 栈编码：d=声明体，b=普通块
function! JsTsFold#Build() abort
  let b:js_ts_fold_levels = ['']
  let l:st = {
        \ 'mode': 'code',
        \ 'string_char': '',
        \ 'regex_class': 0,
        \ 'last': '',
        \ 'stack': [],
        \ 'decl_heading': 0,
        \ 'start_stack_len': 0,
        \ 'paren_depth': 0,
        \ 'pending_body': 0,
        \ 'pending_line': 0,
        \ 'open_line': 0,
        \ 'const_stack': [],
        \ 'is_open': 0,
        \ 'is_close': 0,
        \ }
  let l:depth = 0

  for l:lnum in range(1, line('$'))
    let l:st.line = getline(l:lnum)
    let l:st.decl_heading = (l:st.line =~ s:decl_regex)
    let l:st.start_stack_len = len(l:st.stack)
    let l:st.is_open = 0
    let l:st.is_close = 0
    let l:st.close_count = 0
    let l:st.open_line = 0
    let l:start_paren = l:st.paren_depth
    call s:ScanLine(l:st)

    if l:st.decl_heading && l:st.paren_depth > 0
      \ && l:st.line =~ '^\s*\%(export\s\+\%(default\s\+\)\?\|declare\s\+\|abstract\s\+\)*\%(async\s\+\)\?function'
      " 多行参数的 function 声明：声明头无 `{`，等待下一行 body
      let l:st.pending_body = 1
      let l:st.pending_line = l:lnum
    endif

    " 声明行折叠判定：
    "   - function/class/interface 等留下未匹配 {：stack[start] 标记 'd'
    "   - const 箭头函数体（ScanLine 已 push 'd'）走 'd' 栈闭合
    "   - const 对象/数组字面量（'b'/'a'）：折叠到回到声明前基线
    if l:st.decl_heading && l:st.line !~ 'const\s\+'
      \ && len(l:st.stack) > l:st.start_stack_len
      let l:st.stack[l:st.start_stack_len] = 'd'
      let l:st.is_open = 1
    elseif l:st.decl_heading && l:st.line =~ 'const\s\+'
      \ && len(l:st.stack) > l:st.start_stack_len
      \ && l:st.stack[l:st.start_stack_len] !=# 'd'
      " const 对象/数组字面量，值跨行，折叠到回到声明前基线
      let l:st.is_open = 1
      let l:st.open_line = l:lnum
      call add(l:st.const_stack, [l:lnum, l:st.start_stack_len, l:start_paren])
    elseif l:st.decl_heading && l:st.line =~ 'const\s\+'
      \ && l:st.paren_depth > l:start_paren
      " const 调用表达式跨行（无字面量，如 compute(...)），折叠到回到基线
      let l:st.is_open = 1
      let l:st.open_line = l:lnum
      call add(l:st.const_stack, [l:lnum, l:st.start_stack_len, l:start_paren])
    endif

    " const 跨行表达式闭合：回到声明时的 stack 长度与 paren 层级。
    " 支持嵌套：栈顶满足即闭合，逐个弹出，累积闭合数。
    while !empty(l:st.const_stack)
      \ && len(l:st.stack) == l:st.const_stack[-1][1]
      \ && l:st.paren_depth <= l:st.const_stack[-1][2]
      call remove(l:st.const_stack, -1)
      let l:st.close_count += 1
      let l:st.is_close = 1
    endwhile

    " 生成绝对层级标记：
    "   is_open  -> 声明体开，层 = depth+1，返回 '>' . (depth+1)
    "   is_close -> 声明体闭，返回 's1'（相对降 1，让 } 行留在折叠内）
    "   else     -> 沿用上一行 '='
    if l:st.is_open && l:st.is_close
      call add(b:js_ts_fold_levels, '=')
    elseif l:st.is_open
      let l:depth += 1
      " 多行参数（pending body）：折叠起点在声明头行，本行标记 '='
      if l:st.open_line
        call add(b:js_ts_fold_levels, '=')
        let b:js_ts_fold_levels[l:st.open_line] = '>' . l:depth
      else
        call add(b:js_ts_fold_levels, '>' . l:depth)
      endif
    elseif l:st.is_close
      let l:depth -= l:st.close_count
      if l:depth < 0
        let l:depth = 0
      endif
      if l:st.close_count > 1
        call add(b:js_ts_fold_levels, 's' . l:st.close_count)
      else
        call add(b:js_ts_fold_levels, 's1')
      endif
    else
      call add(b:js_ts_fold_levels, '=')
    endif
  endfor

  let b:js_ts_fold_ready = 1
endfunction

" 逐行扫描（事件驱动状态机，跨行保持状态） ---------------------------------{{{1

" mode: code / string / line_comment / block_comment / regex
function! s:ScanLine(st) abort
  let l:line = a:st.line
  let l:len = strlen(l:line)
  let l:i = 0

  while l:i < l:len
    if a:st.mode ==# 'code'
      " 快进：跳到下一个特殊字符；普通段（字母/数字/空白）一次性跳过
      let l:j = match(l:line, s:code_special, l:i)
      if l:j < 0
        let l:seg = strpart(l:line, l:i)
        if l:seg =~ s:wordchar_re
          let a:st.last = 'x'
        endif
        break
      elseif l:j > l:i
        let l:seg = strpart(l:line, l:i, l:j - l:i)
        if l:seg =~ s:wordchar_re
          let a:st.last = 'x'
        endif
        let l:i = l:j
      endif
    endif

    let l:c = l:line[l:i]

    if a:st.mode ==# 'code' " --------------------------------------------{{{1
      if l:c ==# '/'
        let l:nx = (l:i + 1 < l:len) ? l:line[l:i + 1] : ''
        if l:nx ==# '/'
          let a:st.mode = 'line_comment'
          break
        elseif l:nx ==# '*'
          let a:st.mode = 'block_comment'
          let l:i += 1
        elseif a:st.last ==# '' || a:st.last =~ s:regex_prev
          if l:i > 0 && l:line[l:i - 1] ==# '<'
            " JSX 闭合标签 </tag> 的斜杠不是正则
            let a:st.last = '/'
          else
            let a:st.mode = 'regex'
            let a:st.regex_class = 0
          endif
        else
          let a:st.last = '/'
        endif
      elseif l:c ==# '"' || l:c ==# "'" || l:c ==# '`'
        let a:st.mode = 'string'
        let a:st.string_char = l:c
        let a:st.last = l:c
      elseif l:c ==# '{'
        if a:st.pending_body && a:st.paren_depth == 0
          let a:st.pending_body = 0
          call add(a:st.stack, 'd')
          let a:st.is_open = 1
          let a:st.open_line = a:st.pending_line
        elseif a:st.decl_heading && a:st.last ==# '>'
          " const 箭头函数体：const x = () => { ... }，折叠为声明体
          call add(a:st.stack, 'd')
          let a:st.is_open = 1
        else
          call add(a:st.stack, 'b')
        endif
        let a:st.last = '{'
      elseif l:c ==# '}'
        if !empty(a:st.stack)
          let l:top = remove(a:st.stack, -1)
          if l:top ==# 'd'
            let a:st.is_close = 1
            let a:st.close_count += 1
          endif
          let a:st.mode = 'code'
        endif
        let a:st.last = '}'
      elseif l:c ==# '['
        call add(a:st.stack, 'a')
        let a:st.last = '['
      elseif l:c ==# ']'
        if !empty(a:st.stack)
          let l:top = remove(a:st.stack, -1)
          if l:top ==# 'd'
            let a:st.is_close = 1
            let a:st.close_count += 1
          endif
          let a:st.mode = 'code'
        endif
        let a:st.last = ']'
      elseif l:c ==# '('
        let a:st.paren_depth += 1
        let a:st.last = '('
      elseif l:c ==# ')'
        if a:st.paren_depth > 0
          let a:st.paren_depth -= 1
        endif
        let a:st.last = ')'
      elseif l:c =~ s:wordstart_re
        let l:j = l:i
        while l:j < l:len && l:line[l:j] =~ s:wordchar_re
          let l:j += 1
        endwhile
        let l:word = strpart(l:line, l:i, l:j - l:i)
        if index(s:expr_keywords, l:word) >= 0
          let a:st.last = '('
        else
          let a:st.last = 'x'
        endif
        let l:i = l:j - 1
      elseif l:c !~ '\s'
        let a:st.last = l:c
      endif

    elseif a:st.mode ==# 'string' " --------------------------------------{{{1
      if l:c ==# '\'
        let l:i += 1
      elseif l:c ==# a:st.string_char
        let a:st.mode = 'code'
        let a:st.last = a:st.string_char
      endif

    elseif a:st.mode ==# 'line_comment'
      break

    elseif a:st.mode ==# 'block_comment'
      let l:nx = (l:i + 1 < l:len) ? l:line[l:i + 1] : ''
      if l:c ==# '*' && l:nx ==# '/'
        let a:st.mode = 'code'
        let l:i += 1
      endif

    elseif a:st.mode ==# 'regex' " ----------------------------------------{{{1
      if l:c ==# '\'
        let l:i += 1
      elseif l:c ==# '['
        let a:st.regex_class = 1
      elseif l:c ==# ']'
        let a:st.regex_class = 0
      elseif l:c ==# '/' && !a:st.regex_class
        let a:st.mode = 'code'
        let a:st.last = '/'
      endif
    endif

    let l:i += 1
  endwhile

  " 自愈机制（鲁棒性）：
  "   JS/TS 中单/双引号字符串和正则字面量不能跨行；行尾仍未闭合
  "   即解析出错（引号/斜杠漏配），恢复 code 模式，避免污染后续所有行。
  "   模板字面量 ` 与块注释 /* */ 可合法跨行，保持状态。
  if a:st.mode ==# 'line_comment'
    let a:st.mode = 'code'
  elseif a:st.mode ==# 'regex'
    let a:st.mode = 'code'
  elseif a:st.mode ==# 'string' && a:st.string_char !=# '`'
    let a:st.mode = 'code'
  endif
endfunction
