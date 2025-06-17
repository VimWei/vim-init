" vim: set fdm=marker et ts=4 sw=4 sts=4:

"===================================================
" TOC.vim - Help Table of Contents functions
"===================================================

" Configuration management -----------------------------------------------{{{1
function! s:init_config() abort
    if !exists('s:initialized')
        " Default settings
        let s:position = get(g:, 'TOC#position', 'right')
        let s:close_after_navigating = get(g:, 'TOC#close_after_navigating', 1)
        let s:shift = get(g:, 'TOC#shift', 2)
        let s:autofit = get(g:, 'TOC#autofit', 0)
        let s:initialized = 1
    endif
endfunction

" Version compatibility check --------------------------------------------{{{1
function! s:is_helptoc_supported() abort
    return v:version > 901 || (v:version == 901 && has('patch1230'))
endfunction

" File type check -------------------------------------------------------{{{1
function! s:is_markdown() abort
    return &filetype ==# 'markdown'
endfunction

" Error handling --------------------------------------------------------{{{1
function! s:show_error(message) abort
    echohl WarningMsg
    echo a:message
    echohl None
endfunction

" Show(): show a table of contents using the quickfix window. {{{1
" based on plasticboy/vim-markdown implementation by cirosantilli
function! TOC#Show() abort
    call s:init_config()  " Ensure config is initialized
    let bufname=expand('%')

    " prepare the location-list buffer
    call TOC#Update()
    if s:position ==# 'right'
        let toc_pos = 'rightb vertical'
    elseif s:position ==# 'left'
        let toc_pos = 'topleft vertical'
    elseif s:position ==# 'top'
        let toc_pos = 'topleft'
    elseif s:position ==# 'bottom'
        let toc_pos = 'botright'
    else
        let toc_pos = 'vertical'
    endif
    try
        exe toc_pos . ' lopen'
    catch /E776/ " no location list
        call s:show_error('toc: no places to show')
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

" Set up key mappings for the TOC window {{{1
function! s:setup_mappings() abort
    call s:init_config()  " Ensure config is initialized
    noremap <buffer> q :lclose<CR>
    if s:close_after_navigating
        noremap <buffer> <CR> <CR>:lclose<CR>:normal! zt<CR>
        noremap <buffer> <C-CR> <CR>:normal! zt<CR>
    else
        noremap <buffer> <CR> <CR>:normal! zt<CR>
        noremap <buffer> <C-CR> <CR>:lclose<CR>:normal! zt<CR>
    endif
endfunction

" ReDisplay(bufname): Prepare the location list window for our uses {{{1
function! TOC#ReDisplay(bufname) abort
    call s:init_config()  " Ensure config is initialized
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
        call setline(l, repeat(' ', s:shift*l:level). d.text)

        " keep track of the longest header size (heading level + title)
        let l:lineraw = getline(l)
        let l:line = substitute(l:lineraw, "#", "\\\#", "g")
        let l:total_len = stridx(l:line, ' ') + strdisplaywidth(l:line)
        if l:total_len > l:header_max_len
            let l:header_max_len = l:total_len
        endif
    endfor

    " auto-fit toc window when possible to shrink it
    if (&columns/2) > l:header_max_len && s:autofit == 1
        execute 'vertical resize ' . (l:header_max_len + 5)
    else
        execute 'vertical resize ' . (&columns/4)
    endif

    setlocal nomodified
    setlocal nomodifiable

    setlocal nowrap
    normal! gg

    call s:setup_mappings()
endfunction

" Smart table of contents handler for both helptoc and TOC -----------------{{{1
" This function intelligently handles table of contents based on:
" - Vim version (uses helptoc for Vim 9.1.1230+)
" - File type (uses TOC for markdown files in older Vim or Neovim)
function! TOC#HelpToc() abort
    call s:init_config()
    
    if s:is_helptoc_supported()
        packadd helptoc
        HelpToc
    elseif s:is_markdown()
        call TOC#Show()
    else
        call s:show_error(s:is_markdown() 
            \ ? "helptoc requires Vim 9.1.1230 or later"
            \ : "TOC does not support the current file format")
    endif
endfunction
