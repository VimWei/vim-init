" Filename:      lastmod.vim
" Description:   Updates a last modified timestamp when writing a file
" Maintainer:    Jeremy Cantrell <jmcantrell@gmail.com>
" Last Modified: Fri 2011-05-20 00:44:11 (-0400)

if exists('g:lastmod_loaded') || &cp
    finish
endif

let g:lastmod_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:Trim(value)
    return substitute(a:value, '^\s\+\|\s\+$', '', '')
endfunction

function! s:Squeeze(value)
    return s:Trim(substitute(a:value, '\s\+', ' ', 'g'))
endfunction

function! s:SetVar(name, value)
    if !exists('g:lastmod_{a:name}')
        let g:lastmod_{a:name} = a:value
    endif
endfunction

function! s:GetVar(name)
    if exists('b:lastmod_{a:name}')
        return b:lastmod_{a:name}
    else
        return g:lastmod_{a:name}
    endif
endfunction

call s:SetVar('format', '%a %Y-%m-%d %H:%M:%S (%z)')
call s:SetVar('prefix', 'Last Modified:\s*')
call s:SetVar('suffix', '')
call s:SetVar('lines', 20)

function! s:Update()
    if &modified
        let save_cursor = getpos('.')
        let n = min([s:GetVar('lines'), line('$')])
        let timestamp = strftime(s:GetVar('format'))
        let pat = s:GetVar('prefix').'\zs.*\ze'.s:GetVar('suffix')
        let pat = substitute(pat, '%', '\%', 'g')
        let timestamp = substitute(timestamp, '%', '\%', 'g')
        keepjumps silent exe '1,'.n.'s%^.*'.pat.'.*$%'.timestamp.'%e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfunction

command! -bar LastModUpdate call s:Update()

autocmd BufWritePre * LastModUpdate

let &cpo = s:save_cpo
