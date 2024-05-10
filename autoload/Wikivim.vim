" 在新窗口打开 WikiIndex -------------------------------------------------{{{1
function! Wikivim#OpenWikiIndexTab()
    tabnew
    WikiIndex
    execute 'cd ' . fnameescape(g:wiki_root)
endfunction

" 不同于WikiOpen：采用相对 wikiroot 的路径，tab 打开 ---------------------{{{1
function! Wikivim#OpenWikiPage(filename)
    let l:file_to_open = g:wiki_root . a:filename
    if empty(a:filename) || !filereadable(l:file_to_open)
        let l:file_to_open = g:wiki_root . "index.md"
    endif
    execute "tabedit " . l:file_to_open
    execute 'cd ' . fnameescape(g:wiki_root)
endfunction

" 将普通行转为列表行；更改列表行的列表符号 -------------------------------{{{1
function! Wikivim#ChangeCurrentLineSymbol(count, new_symbol) abort
  let l:start_line = line('.')
  let l:count = a:count > 0 ? a:count : 1
  let l:end_line = l:start_line + l:count - 1

  " 为每一行执行更改操作
  for lnum in range(l:start_line, l:end_line)
    let l:line = getline(lnum)
    let l:indent = matchstr(l:line, '^\s*')

    " 检测当前行是否已经是列表项
    if l:line =~# '^\s*[-*+0-9a-zA-Z.)]\+\s\+'
      " 如果是列表项，替换列表符号并保留一个空格
      let l:line = substitute(l:line, '^\s*\zs[-*+0-9a-zA-Z.)]\+\ze\s\+', '', '')
      let l:line = l:indent . a:new_symbol . ' ' . matchstr(l:line, '\S.*$')
    else
      " 如果不是列表项，则在文字之前、空格之后添加新的列表符号
      let l:content = matchstr(l:line, '\S.*$')
      let l:line = l:indent . a:new_symbol . ' ' . l:content
    endif
    call setline(lnum, l:line)
  endfor
endfunction

finish " -----------------------------------------------------------------{{{1

" 进入 wiki 后，让 pwd 转到 wiki_root
augroup wiki_vim_autochdir
    autocmd!
    autocmd BufEnter *.md,*.wiki if getbufvar(expand('%'), '&filetype') == 'markdown' | execute 'cd ' . g:wiki_root | endif
augroup END
