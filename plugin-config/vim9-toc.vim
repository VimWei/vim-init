" vim9-toc 配置
" 详情查阅 pack/mydev/opt/vim9-toc/doc/toc.txt

let g:toc_level_indicator = '| '
let g:toc_use_helptoc = 1

" 打开目录（统一入口）
nnoremap <leader>ht <Cmd>Toc<CR>

" 示例：给不便折叠的格式注册专用 collector
" function! MyRstCollector() abort
"     let entries = []
"     for lnum in range(1, line('$'))
"         let line = getline(lnum)
"         if lnum < line('$') && line !~# '^\s*$'
"                 \ && getline(lnum + 1) =~# '^[=-]\+\s*$'
"             let lvl = getline(lnum + 1) =~# '^=' ? 1 : 2
"             call add(entries, {'lnum': lnum, 'lvl': lvl, 'text': trim(line)})
"         endif
"     endfor
"     return entries
" endfunction
" call toc#AddCollector('rst', 'MyRstCollector')
