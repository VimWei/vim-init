" TOML folding - based on ftplugin/toml.vim by Kuro96
" https://github.com/Kuro96/.vim
" Folds by [table] / [[array-of-tables]] headers, multiline-string aware.

if exists('b:did_toml_fold_ftplugin')
  finish
endif
let b:did_toml_fold_ftplugin = 1

setlocal foldmethod=expr
setlocal foldexpr=TomlFoldLevel(v:lnum)
setlocal foldtext=TomlFoldText()
setlocal foldlevel=1

let b:undo_ftplugin =
      \ get(b:, 'undo_ftplugin', '')
      \ . ' | setlocal foldmethod< foldexpr< foldtext< foldlevel<'
      \ . ' | unlet! b:did_toml_fold_ftplugin b:toml_fold_tick b:toml_fold_levels'

function! TomlFoldLevel(lnum) abort
  if get(b:, 'toml_fold_tick', -1) != b:changedtick
    call TomlBuildFoldCache()
  endif
  return get(b:toml_fold_levels, a:lnum, 0)
endfunction

function! TomlBuildFoldCache() abort
  let b:toml_fold_levels = [0]
  let l:base = 0
  let l:state = {'stack': [], 'multiline': ''}

  for l:lnum in range(1, line('$'))
    let l:line = getline(l:lnum)
    let l:table = empty(l:state.stack) && empty(l:state.multiline)
          \ ? TomlTableName(l:line)
          \ : ''

    if !empty(l:table)
      let l:base = TomlTableDepth(l:table)
      call add(b:toml_fold_levels, '>' . l:base)
      continue
    endif

    let l:before = len(l:state.stack)
    call TomlScanLine(l:line, l:state)
    let l:after = len(l:state.stack)
    let l:level = l:base + max([l:before, l:after])

    call add(b:toml_fold_levels,
          \ l:after > l:before ? '>' . l:level : l:level)
  endfor

  let b:toml_fold_tick = b:changedtick
endfunction

function! TomlFoldText() abort
  let l:line = substitute(getline(v:foldstart), '^\s*', '', '')
  let l:line_count = v:foldend - v:foldstart + 1
  return l:line . '  [' . l:line_count . ' lines]'
endfunction

function! TomlTableName(line) abort
  let l:table = matchstr(a:line,
        \ '^\s*\[\[\s*\zs.\{-}\ze\s*\]\]\s*\%($\|#\)')

  if empty(l:table)
    let l:table = matchstr(a:line,
          \ '^\s*\[\s*\zs.\{-}\ze\s*\]\s*\%($\|#\)')
  endif

  return l:table
endfunction

function! TomlTableDepth(table) abort
  let l:depth = 1
  let l:quote = ''
  let l:escaped = 0

  for l:char in split(a:table, '\zs')
    if l:quote ==# '"'
      if l:escaped
        let l:escaped = 0
      elseif l:char ==# '\'
        let l:escaped = 1
      elseif l:char ==# '"'
        let l:quote = ''
      endif
    elseif l:quote ==# "'"
      if l:char ==# "'"
        let l:quote = ''
      endif
    elseif l:char ==# '"' || l:char ==# "'"
      let l:quote = l:char
    elseif l:char ==# '.'
      let l:depth += 1
    endif
  endfor

  return l:depth
endfunction

function! TomlScanLine(line, state) abort
  let l:index = 0
  let l:length = strlen(a:line)

  while l:index < l:length
    if !empty(a:state.multiline)
      let l:delimiter = a:state.multiline

      if strpart(a:line, l:index, 3) ==# l:delimiter
        let a:state.multiline = ''
        call remove(a:state.stack, -1)
        let l:index += 3
      elseif l:delimiter ==# '"""' && strpart(a:line, l:index, 1) ==# '\'
        let l:index += 2
      else
        let l:index += 1
      endif
      continue
    endif

    let l:char = strpart(a:line, l:index, 1)

    if l:char ==# '#'
      break
    elseif strpart(a:line, l:index, 3) ==# '"""'
      let a:state.multiline = '"""'
      call add(a:state.stack, '"""')
      let l:index += 3
    elseif strpart(a:line, l:index, 3) ==# "'''"
      let a:state.multiline = "'''"
      call add(a:state.stack, "'''")
      let l:index += 3
    elseif l:char ==# '"'
      let l:index += 1
      while l:index < l:length
        let l:char = strpart(a:line, l:index, 1)
        if l:char ==# '\'
          let l:index += 2
        elseif l:char ==# '"'
          let l:index += 1
          break
        else
          let l:index += 1
        endif
      endwhile
    elseif l:char ==# "'"
      let l:index = matchend(a:line, "'", l:index + 1)
      if l:index < 0
        break
      endif
    elseif l:char ==# '[' || l:char ==# '{'
      call add(a:state.stack, l:char)
      let l:index += 1
    elseif l:char ==# ']' || l:char ==# '}'
      let l:opener = l:char ==# ']' ? '[' : '{'
      if !empty(a:state.stack) && a:state.stack[-1] ==# l:opener
        call remove(a:state.stack, -1)
      endif
      let l:index += 1
    else
      let l:index += 1
    endif
  endwhile
endfunction
