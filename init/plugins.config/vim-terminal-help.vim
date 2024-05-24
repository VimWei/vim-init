" https://www.github.com/skywind3000/vim-terminal-help
" 在vim，使用 ALT+= 切换打开/关闭terminal
" 在Vim和terminal，ALT+SHIFT+hjkl 用来在终端窗口和其他窗口之间跳转
" 在terminal，使用 drop 打开文件
" 在terminal，使用 ALT+- 粘贴 0 号复制专用寄存器
" 在terminal，使用 ALT+q 进入normal模式，之后用i或a等则进入insert模式
" 使用 exit 彻底退出terminal，并关闭窗口
" let g:terminal_shell='pwsh'   " 使用PowerShell Core 7.x

let g:terminal_cwd = 0
let g:terminal_pos = 'vert botright'    " 默认为rightbelow
let g:terminal_height = 70  " 设置高度(split，默认10)或宽度(vsplit，建议70)
let g:terminal_kill = 'term'
let g:terminal_close = 1
