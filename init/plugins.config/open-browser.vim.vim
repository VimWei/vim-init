" http://www.github.com/tyru/open-browser.vim

" gx ---------------------------------------------------------------------{{{1
" gx使用系统默认工具打开光标下的文件、URL等
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" Open Plugin in github --------------------------------------------------{{{1
command! Github call OpenVimPlugGithubProject()
nnoremap <Leader>gx :call OpenVimPlugGithubProject()<CR>
function! OpenVimPlugGithubProject()
    " 保存当前寄存器和光标位置
    let l:save_reg = getreg('"')
    let l:save_cursor = getpos('.')

    " 获取当前所在位置的引号中的内容
    normal! yi'
    let l:selected_text = getreg('"')
    let l:selected_text = 'https://github.com/' . l:selected_text

    " 恢复寄存器和光标位置
    call setreg('"', l:save_reg)
    call setpos('.', l:save_cursor)

    " 调用 OpenBrowser 命令，并传递 yanked 文本
    execute 'OpenBrowser' l:selected_text
endfunction
