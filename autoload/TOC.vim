" vim: set fdm=marker et ts=4 sw=4 sts=4:

" Init(): set up defaults, create TOC command {{{1
function! TOC#Init() abort
    " set up defaults {{{2
    " where to open the location list
    if !exists('g:TOC#position')
        let g:TOC#position = 'right'
    endif
    if !exists('g:TOC#close_after_navigating')
        let g:TOC#close_after_navigating = 1
    endif
    " the number of spaces per level in toc
    if !exists('g:TOC#shift')
        let g:TOC#shift = 2
    endif
    " create :TOC command {{{2
    command! -buffer TOC call TOC#Show()
    "}}}
endfunction

" Show(): show a table of contents using the quickfix window. {{{1
" based on plasticboy/vim-markdown implementation by cirosantilli
function! TOC#Show() abort
    let bufname=expand('%')

    " prepare the location-list buffer
    call TOC#Update()
    if g:TOC#position ==# 'right'
        let toc_pos = 'rightb vertical'
    elseif g:TOC#position ==# 'left'
        let toc_pos = 'topleft vertical'
    elseif g:TOC#position ==# 'top'
        let toc_pos = 'topleft'
    elseif g:TOC#position ==# 'bottom'
        let toc_pos = 'botright'
    else
        let toc_pos = 'vertical'
    endif
    try
        exe toc_pos . ' lopen'
    catch /E776/ " no location list
        echohl ErrorMsg
        echom 'toc: no places to show'
        echohl None
        return
    endtry

    call TOC#ReDisplay(bufname)
endfunction

" Update(): update location list {{{1
function! TOC#Update() abort
    try
        silent lvimgrep /\(^\S.*\(\n[=-]\+\n\)\@=\|^#\{1,6}[^.]\|\%^%\)/j %
    catch /E480/
        return
    catch /E499/ " % has no name
        return
    endtry
endfunction

" ReDisplay(bufname): Prepare the location list window for our uses {{{1
function! TOC#ReDisplay(bufname) abort
    if len(getloclist(0)) == 0
        lclose
        return
    endif

    execute 'setlocal statusline=[TOC]\ '.escape(a:bufname, ' ')
    execute 'setlocal statusline+=%='
    execute 'setlocal statusline+=\ %0(%l/%L=%p%%%)'

    " change the contents of the location-list buffer
    setlocal modifiable
    " vint: -ProhibitCommandWithUnintendedSideEffect -ProhibitCommandRelyOnUser
    silent %s/\v^([^|]*\|){2} #//e

    let l:header_max_len = 0

    " vint: +ProhibitCommandWithUnintendedSideEffect +ProhibitCommandRelyOnUser
    for l in range(1, line('$'))
        " this is the location-list data for the current item
        let d = getloclist(0)[l-1]  " -1 because numeration begins from 0
        " titleblock
        if match(d.text, '^%') > -1
            let l:level = 0
        " atx headers
        elseif match(d.text, '^#') > -1
            let l:level = len(matchstr(d.text, '#*', 'g'))-1
            " let d.text = '· '.d.text[l:level+2:]
        " setex headers
        else
            let l:next_line = getbufline(bufname(d.bufnr), d.lnum+1)
            if match(l:next_line, '=') > -1
        	let l:level = 0
            elseif match(l:next_line, '-') > -1
        	let l:level = 1
            endif
            " let d.text = '· '.d.text
        endif
        call setline(l, repeat(' ', g:TOC#shift*l:level). d.text)

        " keep track of the longest header size (heading level + title)
        let l:lineraw = getline(l)
        let l:line = substitute(l:lineraw, "#", "\\\#", "g")
        let l:total_len = stridx(l:line, ' ') + strdisplaywidth(l:line)
        if l:total_len > l:header_max_len
            let l:header_max_len = l:total_len
        endif
    endfor

    " auto-fit toc window when possible to shrink it
    let l:toc_autofit = get(g:, "TOC#autofit", 0)
    if (&columns/2) > l:header_max_len && l:toc_autofit == 1
        execute 'vertical resize ' . (l:header_max_len + 5)
    else
        execute 'vertical resize ' . (&columns/4)
    endif

    setlocal nomodified
    setlocal nomodifiable

    setlocal nowrap
    normal! gg

    noremap <buffer> q :lclose<CR>
    noremap <buffer> <expr> <CR> g:TOC#close_after_navigating == 1 ? '<CR>:lclose<CR>:normal! zt<CR>' : '<CR>:normal! zt<CR>'
    noremap <buffer> <expr> <C-CR> g:TOC#close_after_navigating == 1 ? '<CR>:normal! zt<CR>': '<CR>:lclose<CR>:normal! zt<CR>'
endfunction
