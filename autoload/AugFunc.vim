" Augroup's function

" AutoLineNumber ---------------------------------------------------------{{{1

function s:isBackListFiletypes() abort
    let l:ft = &filetype
    if l:ft ==# '' || l:ft =~# '\v^(list|LuaTree|coc-explorer|cocactions|any-jump|utools|coctree)$'
        return v:true
    endif
    return v:false
endfunction

function! AugFunc#AbsNum()
    if s:isBackListFiletypes()
        return
    endif
    setlocal norelativenumber number
endfunction

function! AugFunc#RelNum()
    if s:isBackListFiletypes()
        return
    endif
    setlocal relativenumber number
endfunction

" AutoJumpLastPos --------------------------------------------------------{{{1

function! AugFunc#JumpLastPos()
    try
        if &buftype != '' || !filereadable(expand('%'))
            return 0
        endif
        if line("'\"") <= line('$')
            normal! g`"
            return 1
        endif
        catch /.*/
    endtry
endfunction
