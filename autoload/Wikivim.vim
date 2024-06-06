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

" Update Journal Index ---------------------------------------------------{{{1
function! Wikivim#UpdateJournalIndex()
    execute 'normal! dG'
    WikiJournalIndex
    execute 'normal! gg'
endfunction

finish " -----------------------------------------------------------------{{{1

" 进入 wiki 后，让 pwd 转到 wiki_root
augroup wiki_vim_autochdir
    autocmd!
    autocmd BufEnter *.md,*.wiki if getbufvar(expand('%'), '&filetype') == 'markdown' | execute 'cd ' . g:wiki_root | endif
augroup END
