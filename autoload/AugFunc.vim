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
        " 排除特殊缓冲区（如终端、Quickfix、帮助页面等）
        " 排除不可读文件（如新创建的未保存缓冲区、无权限文件等）
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
