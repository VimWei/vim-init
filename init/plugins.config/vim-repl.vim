" https://www.github.com/sillybun/vim-repl

" REPL（Read-Eval-Print Loop，读取-求值-输出的循环）简单的交互式编程环境
" Grab some text and send it to Vim Terminal： VIM --(text)--> Vim Terminal

" Leader + re：打开或关闭REPL窗口，运行iPython，快捷键可配置
" 在普通模式下按<leader>w把当前行发送到REPL窗口
" 在普通模式下在代码块的第一行按<leader>w，把一块代码发送到REPL窗口
" 在选择模式下选中多行代码按<leader>w把一块代码发送到REPL窗口

let g:repl_program = {
            \   'python': 'ipython',
            \   'default': 'ipython',
            \   'vim': 'vim -e',
            \   }
let g:repl_predefine_python = {
            \   'numpy': 'import numpy as np',
            \   'matplotlib': 'from matplotlib import pyplot as plt'
            \   }
let g:repl_cursor_down = 1
let g:repl_python_automerge = 1
let g:repl_ipython_version = '7'

nnoremap <leader>re :REPLToggle<Cr>
" autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<Cr>
" autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<Cr>
" autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<Cr>

let g:repl_position = 3     "0表示出现在下方，1表示出现在上方，2在左边，3在右边
