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
    " 优先匹配引号内容，光标可在行内任意位置
    let quote_pattern = '''\zs[^'']\+\ze'''
    let l:selected_text = matchstr(line, quote_pattern)
    " 根据光标所在位置，提取有效内容并验证格式
    if empty(l:selected_text)
        let col = col('.') - 1
        let left = col == 0 ? 0 : strridx(line[:col-1], ' ') + 1
        let right = stridx(line[col:], ' ')
        let right = right == -1 ? len(line) : col + right
        let l:selected_text = line[left : right-1]
        if l:selected_text !~ '^\S\+/\S\+$'
            echom "No valid GitHub project found"
            return
        endif
    endif
    let l:githubProject = 'https://github.com/' . l:selected_text
    execute 'OpenBrowser' l:githubProject
endfunction
