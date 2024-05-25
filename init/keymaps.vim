"===================================================
" Mapping & Abbreviation settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" basic ------------------------------------------------------------------{{{1
" Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
set winaltkeys=no
" 避免误操作进入 Ex 模式
nnoremap Q <nop>

" VIMRC ------------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Vimrc.vim
command! VI call Vimrc#EditInitVimrc("init.vim")
command! VV call Vimrc#EditInitVimrc("init.vim", "vsp")
command! VE call Vimrc#EditInitVimrc("essential.vim")
command! VT call Vimrc#EditInitVimrc("tabsize.vim")
command! VS call Vimrc#EditInitVimrc("statusline.vim")
command! VP call Vimrc#EditInitVimrc("plugins.vim")
command! VK call Vimrc#EditInitVimrc("keymaps.vim")
command! VC call Vimrc#EditInitVimrc("colorstyle.vim")
command! VG call Vimrc#EditInitVimrc("guistyle.vim")
command! VM call Vimrc#EditInitVimrc("vim-quickui.vim")
command! VN call Vimrc#EditInitVimrc("vim-navigator.vim")
command! VA call Vimrc#EditInitVimrc("autoload.vim")

" Vim Help ---------------------------------------------------------------{{{1
" 垂直右侧窗口打开help
cabbrev vh vert botright help
cabbrev th tab help

"在新标签页打开帮助
nnoremap <leader>h :tab help<CR>

" 查询加亮内容的帮助，适用于比word更复杂的情形
vnoremap <leader>h y:tab help <C-R>*<CR>

" 查询当前光标下word的帮助
nnoremap <leader><leader>h :tab help <C-R><C-W><CR>

" CD ---------------------------------------------------------------------{{{1
" 命令行中将 %% 展开为活动缓冲区所在目录的路径，相当于 %:h<Tab>
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:p:h').'/' : '%%'

" 改变当前工作目录为当前缓冲区所在的目录
command! CD cd %:p:h

" 使用Netrw快速进入当前缓冲区所在目录
map <leader>ew :<C-u>e %%<CR>
map <leader>es :<C-u>sp %%<CR>
map <leader>ev :<C-u>vsp %%<CR>
map <leader>et :<C-u>tabe %%<CR>

" Buffer -----------------------------------------------------------------{{{1
" 缓存：插件 unimpaired 中定义了 [b, ]b 来切换缓存
noremap <silent> <leader>bn :bn<cr>
noremap <silent> <leader>bp :bp<cr>

" Tab --------------------------------------------------------------------{{{1
" tab 新建、关闭
noremap <silent> <leader>tc :tabnew<cr>
noremap <silent> <leader>tq :tabclose<cr>
noremap <silent> <leader>to :tabonly<cr>
" tab 左移、右移
noremap <silent><leader>th :call Tab#MoveLeft()<cr>
noremap <silent><leader>tl :call Tab#MoveRight()<cr>
noremap <silent><m-left> :call Tab#MoveLeft()<cr>
noremap <silent><m-right> :call Tab#MoveRight()<cr>

" tab 切换: <leader>+N 或 ALT+N
let s:array = [')', '!', '@', '#', '$', '%', '^', '&', '*', '(']
for i in range(10)
    let x = (i == 0)? 10 : i
    let c = s:array[i]
    exec "noremap <silent><M-".i."> ".x."gt"
    exec "noremap <silent><leader>".i." ".x."gt"
    exec "inoremap <silent><M-".i."> <ESC>".x."gt"
    if get(g:, 'vim_no_meta_shift_num', 0) == 0
        exec "noremap <silent><M-".c."> ".x."gt"
        exec "inoremap <silent><M-".c."> <ESC>".x."gt"
    endif
endfor

" Window -----------------------------------------------------------------{{{1
" 正常模式下 alt+j,k,h,l 调整分割窗口大小
nnoremap <M-k> :resize +5<CR>
nnoremap <M-j> :resize -5<CR>
nnoremap <M-h> :vertical resize -5<CR>
nnoremap <M-l> :vertical resize +5<CR>

" List -------------------------------------------------------------------{{{1
" 详情查阅 ../autoload/List.vim
nnoremap <silent> gl* :<C-u>execute 'call List#ChangeSymbol(' . v:count1 . ', "*")'<CR>
nnoremap <silent> gl- :<C-u>execute 'call List#ChangeSymbol(' . v:count1 . ', "-")'<CR>
nnoremap <silent> gl+ :<C-u>execute 'call List#ChangeSymbol(' . v:count1 . ', "+")'<CR>
nnoremap <silent> gl1 :<C-u>execute 'call List#ChangeSymbol(' . v:count1 . ', "1.")'<CR>
nnoremap <silent> gl2 :<C-u>execute 'call List#ChangeSymbol(' . v:count1 . ', "1)")'<CR>
nnoremap <silent> glA :<C-u>execute 'call List#ChangeSymbol(' . v:count1 . ', "A.")'<CR>
nnoremap <silent> gla :<C-u>execute 'call List#ChangeSymbol(' . v:count1 . ', "a)")'<CR>
nnoremap <silent> gld :<C-u>execute 'call List#ChangeSymbol(' . v:count1 . ', "d")'<CR>

" ABDelete and ABYank ----------------------------------------------------{{{1
" 复制或删除两个标记之间的内容
command! ABDelete 'a,'bd
command! ABYank 'a,'by
nnoremap <Leader>md :ABDelete<CR>
nnoremap <Leader>my :ABYank<CR>

" Word Processor ---------------------------------------------------------{{{1

" 插入模式移动光标 alt + 方向键
inoremap <M-j> <C-o>gj
inoremap <M-k> <C-o>gk
inoremap <M-h> <left>
inoremap <M-l> <Right>

" 让旁边的参考窗口上下移动光标行
" noremap <M-Up> <C-w>pk<C-w>p
" noremap <M-Down> <C-w>pj<C-w>p

" 让旁边的参考窗口上下滚屏
noremap <M-u> <C-w>p<C-u><C-w>p
noremap <M-d> <C-w>p<C-d><C-w>p

" 移动至上下行：使用vim-unimpaired.vim的[e或]e

" 移动当前行至对面窗口
" nnoremap <C-Left> dd<C-y><C-y><C-w>hpzz<C-w>p
" nnoremap <C-Right> dd<C-y><C-y><C-w>lpzz<C-w>p

" 移动对面当前行至当前窗口
" 移动右侧行至当前的左窗口
nnoremap <leader>mh <C-w>ldd<C-w>hpzt4<C-y>
" 移动左侧行至当前的右窗口
" nnoremap <C-Right> <C-w>hdd<C-w>lpzt

" 选中全行
nnoremap vv ^vg_

" 在光标之后插入时间戳
nnoremap <leader>ts a<C-R>=strftime("%Y-%m-%d %A %H:%M:%S")<CR><Esc>
inoremap <M-t> <C-R>=strftime("%Y-%m-%d %A %H:%M:%S")<CR>
" 开启新行插入时间戳，并在其之后增加空行
command! Timestamp exe "normal o".strftime("%Y-%m-%d %A %H:%M:%S")."<C-O>o"

" FoldToggle -------------------------------------------------------------{{{1
set nofoldenable
set foldlevel=1 "低于或等于的折叠默认展开，高于此折叠级别的折叠会被关闭
" set foldclose=all " 用于光标移出后，自动关闭高于foldlevel的折叠。
" Vim光标所在处的折叠开关
" nnoremap <expr> <space> (foldlevel(line('.'))>0) ? "za" : "<space>"
" nnoremap <expr> <S-space> (foldlevel(line('.'))>0) ? "zA" : "<S-space>"
nnoremap <Leader>z za
nnoremap <S-space> zMzv
nnoremap          zv zMzvzz
nnoremap <silent> zj zcjzOzz
nnoremap <silent> zk zckzOzz

" WikiGrep ---------------------------------------------------------------{{{1
" 搜索当前工作目录下的所有文件，但只搜索第一个匹配：
" Vim 8.1 及之前版本为每个文件一个匹配，Vim 8.2 变更为整个范围仅一个匹配
command! -nargs=1 WikiGrepBrief 1vimgrep /<args>/ **/*.md | copen 8
" 搜索当前工作目录下的所有文件的所有行，但只搜索每行的第一个匹配
command! -nargs=1 WikiGrepNormal vimgrep /<args>/ **/*.md | copen 8
" 搜索当前工作目录下的所有文件的所有行，且搜索每行的多个匹配
command! -nargs=1 WikiGrepVerbal vimgrep /<args>/g **/*.md | copen 8
" 采用Verbal模式搜索Tags
command! -nargs=1 WikiGrepTags vimgrep /:<args>:/g **/*.md | copen 8

" VisualStar -------------------------------------------------------------{{{1
"用*或#对选中文字进行搜索
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

" nohlsearch -------------------------------------------------------------{{{1
" 清屏可以暂时关闭高亮
" nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR>:ccl<CR><C-l>

" GoldenDict -------------------------------------------------------------{{{1
"nnoremap <c-c> <esc>muhebyiw`u
nnoremap <c-c> <esc>muyiw`u
"inoremap <c-c> <esc>muhebyiw`ua
inoremap <c-c> <esc>muyiw`ua
vnoremap <c-c> ygv
