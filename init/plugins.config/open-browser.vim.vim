" http://www.github.com/tyru/open-browser.vim

" gx ---------------------------------------------------------------------{{{1
" gx使用系统默认工具打开光标下的文件、URL等
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" Open Plugin in github --------------------------------------------------{{{1
command! Github call OpenGithubProject()
nnoremap <Leader>gx :call OpenGithubProject()<CR>
function! OpenGithubProject()
    let line = getline('.')
    let pattern = '''\zs[^'']\+\ze'''
    let l:selected_text = matchstr(line, pattern)
    if empty(l:selected_text)
        echom "No plugin project found on the line."
        return
    endif
    let l:githubProject = 'https://github.com/' . l:selected_text
    execute 'OpenBrowser' l:githubProject
endfunction
