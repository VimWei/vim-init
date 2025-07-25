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
    execute 'normal! gg'
    let searchPattern = '#\s\d\d\d\d'
    let found = search(searchPattern, 'W')
    if !found
        call append(line('$'), ['', ''])
        execute 'normal! G'
    endif
    execute 'normal! dG'
    WikiJournalIndex
    execute 'normal! gg'
endfunction

" MyUrlTransform ---------------------------------------------------------{{{1
" 将wiki链接文本转为合法且清晰的文件名
function! Wikivim#MyUrlTransform(text)
    let l:valid_filename = substitute(a:text, '[:*\?"<>|`：!@#$%&*‘’'']', '', 'g')
    let l:formatted_filename = substitute(l:valid_filename, '\s\+\|[.。,，/+"“”<>()（）《》]', '-', 'g')
    let l:formatted_filename = substitute(l:formatted_filename, '-\+', '-', 'g')
    let l:cleaned_filename = substitute(l:formatted_filename, '^-\|-$', '', 'g')
    return tolower(l:cleaned_filename)
endfunction

finish " -----------------------------------------------------------------{{{1

" 进入 wiki 后，让 pwd 转到 wiki_root
augroup wiki_vim_autochdir
    autocmd!
    autocmd BufEnter *.md,*.wiki if getbufvar(expand('%'), '&filetype') == 'markdown' | execute 'cd ' . g:wiki_root | endif
augroup END
