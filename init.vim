"===================================================
" General Vim settings by W.Chen
" Sourced by: $HOME/vimfiles/vimrc
"===================================================
" 防止重复加载
if get(s:, 'loaded', 0) != 0
    finish
else
    let s:loaded = 1
endif

" 取得本文件所在的目录，并加入 runtimepath
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
execute 'set runtimepath+='.s:home

" 定义加载命令
command! -nargs=1 LoadScript execute 'so '.s:home.'/'.'<args>'

LoadScript init/essential.vim   " 加载基础配置
LoadScript init/status.vim      " 加载status样式
LoadScript init/search.vim      " 加载忽略列表
LoadScript init/guistyle.vim    " 加载界面样式
LoadScript init/keymaps.vim     " 加载按键映射
LoadScript init/plugins.vim     " 加载功能插件
LoadScript init/autoload.vim    " 延时自动加载
LoadScript init/colorscheme.vim " 延时自动加载

finish

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
    *  借助vim-sneak，使用f<char><char> 快速定位到适当位置
    *  借助EasyMotion，使用<leader><leader>w 快速定位到适当位置
    *  Ctrl-w_f: 分割窗口并打开光标下的文件
    *  Ctrl-w_gf: 在新标签页打开光标下的文件
    *  Ctrl-o: 后退，转到跳转表里较旧的光标位置
