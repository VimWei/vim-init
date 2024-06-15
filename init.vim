"===================================================
" General Vim settings by W.Chen
" Sourced by: $HOME/vimfiles/vimrc
"===================================================

" Prevent reloading ------------------------------------------------------{{{1
if get(s:, 'loaded', 0) != 0
    finish
else
    let s:loaded = 1
endif

" Leader key -------------------------------------------------------------{{{1
nnoremap <space> <nop>
let mapleader = "\<space>"

" g:viminit --------------------------------------------------------------{{{1
let g:viminit = fnamemodify(resolve(expand('<sfile>:p')), ':h')
execute 'set runtimepath+=' . g:viminit . ',' . g:viminit . '/after'
let g:viminit = substitute(g:viminit . '/', '\\', '/', 'g')
let g:viminitparent = fnamemodify(g:viminit, ':h:h') . '/'

" LoadScript -------------------------------------------------------------{{{1
execute 'so ' . g:viminit . 'init/essential.vim'
execute 'so ' . g:viminit . 'init/tabsize.vim'
execute 'so ' . g:viminit . 'init/plugins.vim'
execute 'so ' . g:viminit . 'init/keymaps.vim'
execute 'so ' . g:viminit . 'init/autoload.vim'
execute 'so ' . g:viminit . 'init/guistyle.vim'
execute 'so ' . g:viminit . 'init/statusline.vim'
execute 'so ' . g:viminit . 'init/colorstyle.vim'

if has('nvim')
    runtime neovim.lua
endif

" Vimrc#AutoReload -------------------------------------------------------{{{1
" 当pwd为vim-init/时，修订并保存 *.vim 文件后，系统将自动重新加载
augroup VimrcAutoReload
    autocmd!
    autocmd BufWritePost init.vim call Vimrc#AutoReload(expand('<afile>:p'))
    autocmd BufWritePost init/*.vim call Vimrc#AutoReload(expand('<afile>:p'))
    autocmd BufWritePost autoload/*.vim call Vimrc#AutoReload(expand('<afile>:p'))
augroup END

finish " -----------------------------------------------------------------{{{1

导航Tips：
 * :find  在 'path' 里找到 {file}，然后编辑 :edit 它
    * 用 :find <Tab> 选择编辑当前工作目录及子目录下的文件
    * 用 :find %%<Tab> 选择编辑当前缓冲区所在目录及子目录下的文件
    * 用 :CD 切换工作目录为当前缓冲区所在目录
    * 用 :cd.. 切换工作目录为上一级目录

 * <C-n>: 使用 Netrw 导航
    * - 打开当前缓冲区所在目录
    * :Explore[!]  [dir] 探索当前缓冲区所在的目录 = <leader>ew<CR>
    * :Sexplore[!] [dir] 水平分割并探索当前缓冲区所在的目录 = <leader>es<CR>
    * :Vexplore[!] [dir] 垂直分割并探索当前缓冲区所在的目录 = <leader>ev<CR>
    * :Texplore[!] [dir] 在新标签页探索当前缓冲区所在的目录 = <leader>et<CR>

 * <leader>f: 使用 Leaderf 搜索
    * 若当前缓冲区在工作目录下，则搜索工作目录
    * 若当前缓冲区不在工作目录下，则搜索当前缓冲区所在目录
    * 用 :CD 切换工作目录为当前缓冲区所在目录
    * 用 :cd.. 切换工作目录为上一级目录

 * gf: 在当前窗口打开光标下的文件
    *  借助EasyMotion，使用f<char><char> 快速定位到适当位置
    *  借助EasyMotion，使用<leader><leader>w 快速定位到适当位置
    *  Ctrl-w_f: 分割窗口并打开光标下的文件
    *  Ctrl-w_gf: 在新标签页打开光标下的文件
    *  Ctrl-o: 后退，转到跳转表里较旧的光标位置
