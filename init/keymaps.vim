"===================================================
" Mapping & Abbreviation settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" basic -------------------------------------------------------------------{{{1
let mapleader = "\<space>"

" Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
set winaltkeys=no

" 设置 vim 相关文件打开后默认折叠方式为 marker
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" VIMRC -------------------------------------------------------------------{{{1
" 打开 vim-init/init.vim 或其子目录下的 VIMRC 文档
let s:viminit = fnamemodify(resolve(expand('<sfile>:p')), ':h:h').'/'
let s:init = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/'
function! EditInitVimrc(filename, ...)
    " 根据文件名称，决定文件所在路径
    if a:filename == "init.vim"
        let l:filepath = s:viminit . a:filename
    else
        let l:filepath = s:init . a:filename
    endif
    " 若提供了额外参数，则使用指定方案，否则使用 tabedit 打开
    let splittype = a:0 > 0 ? a:1 : 'tabedit'
    if splittype == "edit"
        execute "edit " . l:filepath
    elseif splittype == "vsp"
        execute "vert botright split " . l:filepath
    else
        " 默认打开方式，没有参数或参数错误是时的打开方式
        execute "tabedit " . l:filepath
    endif
    " 设置vim-init/为工作目录
    execute "cd " . s:viminit
endfunction
command! VI call EditInitVimrc("init.vim")
command! VV call EditInitVimrc("init.vim", "vsp")
command! VE call EditInitVimrc("essential.vim")
command! VT call EditInitVimrc("tabsize.vim")
command! VL call EditInitVimrc("statusline.vim")
command! VS call EditInitVimrc("search.vim")
command! VG call EditInitVimrc("guistyle.vim")
command! VK call EditInitVimrc("keymaps.vim")
command! VP call EditInitVimrc("plugins.vim")
command! VQ call EditInitVimrc("quickui.vim")
command! VA call EditInitVimrc("autoload.vim")
command! VC call EditInitVimrc("colorscheme.vim")

" Vim Help -----------------------------------------------------{{{1
" 垂直右侧窗口打开help
cabbrev vh vert botright help

"在新标签页打开帮助
nnoremap <leader>h :tab help<CR>

" 查询加亮内容的帮助，适用于比word更复杂的情形
vnoremap <leader>h y:tab help <C-R>*<CR>

" 查询当前光标下word的帮助
nnoremap <leader><leader>h :tab help <C-R><C-W><CR>

" CD ----------------------------------------------------------------------{{{1
" 命令行中将 %% 展开为活动缓冲区所在目录的路径，相当于 %:h<Tab>
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:p:h').'/' : '%%'

" 改变当前工作目录为当前缓冲区所在的目录
command! CD cd %:p:h

" 快速进入当前缓冲区所在目录
map <leader>ew :<C-u>e %%<CR>
map <leader>es :<C-u>sp %%<CR>
map <leader>ev :<C-u>vsp %%<CR>
map <leader>et :<C-u>tabe %%<CR>

" Buffer ------------------------------------------------------------------{{{1
" 缓存：插件 unimpaired 中定义了 [b, ]b 来切换缓存
noremap <silent> <leader>bn :bn<cr>
noremap <silent> <leader>bp :bp<cr>

" Tab ---------------------------------------------------------------------{{{1
" tab 新建、关闭
noremap <silent> <leader>tc :tabnew<cr>
noremap <silent> <leader>tq :tabclose<cr>
noremap <silent> <leader>to :tabonly<cr>
" tab 左移、右移
noremap <silent><leader>th :call Tab_MoveLeft()<cr>
noremap <silent><leader>tl :call Tab_MoveRight()<cr>
noremap <silent><m-left> :call Tab_MoveLeft()<cr>
noremap <silent><m-right> :call Tab_MoveRight()<cr>
function! Tab_MoveLeft()
    let l:tabnr = tabpagenr() - 2
    if l:tabnr >= 0
        exec 'tabmove '.l:tabnr
    endif
endfunc
function! Tab_MoveRight()
    let l:tabnr = tabpagenr() + 1
    if l:tabnr <= tabpagenr('$')
        exec 'tabmove '.l:tabnr
    endif
endfunc

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

" Window ------------------------------------------------------------------{{{1
" 正常模式下 alt+j,k,h,l 调整分割窗口大小
nnoremap <M-j> :resize +5<CR>
nnoremap <M-k> :resize -5<CR>
nnoremap <M-h> :vertical resize -5<CR>
nnoremap <M-l> :vertical resize +5<CR>

" Vimwiki -----------------------------------------------------------------{{{1

" command! VR call RoadShowIndex()
" function! RoadShowIndex()
"     execute "tabedit " . g:vimwiki_list[0].path. "Research/路演.md"
" endfunction

" 定义一个接受一个参数的命令，参数为要打开的文件名
function! VimwikiFile(filename)
    let l:file_to_open = g:vimwiki_list[0].path . a:filename
    if empty(a:filename) || !filereadable(l:file_to_open)
        let l:file_to_open = g:vimwiki_list[0].path . "index.md"
    endif
    execute "tabedit " . l:file_to_open
endfunction
command! -nargs=? VW call VimwikiFile(<q-args>)
command! RS call VimwikiFile('Research/路演.md')

" Markdown ----------------------------------------------------------------{{{1
" 将文档类型设置为markdown
nnoremap <leader>mm :set ft=markdown<CR>

" 将行转为段落，并格式化，explode
" nnoremap <leader>me :%s/.\@<=$\n^\(.\+\)\@=/\r\r/e<CR>:<C-u>nohlsearch<CR>ggVGgq
" vnoremap <leader>me :s/.\@<=$\n^\(.\+\)\@=/\r\r/e<CR>:<C-u>nohlsearch<CR>
function! Explode2P() abort range
    let firstline = a:firstline
    let lastline = a:lastline
    if a:firstline == a:lastline
        let firstline = 1
        let lastline = line('$')
    endif
    let l:pattern = '.\@<=$\n^\(.\+\)\@='

    " 计算有多少个满足pattern的匹配，并设计若没有匹配时的处理
    let l:cmd_match = firstline . ',' . lastline . 's/' . l:pattern . '//gn'
    redir => l:output_match
    try
        silent! execute l:cmd_match
    catch
        redir END
        return
    endtry
    redir END
    let l:match_count = split(l:output_match)[0] + 0

    " 执行满足pattern的替换
    let l:pattern = 's/' . l:pattern . '/\r\r/e'
    let l:pattern = firstline . ',' . lastline . l:pattern
    execute l:pattern
    nohlsearch

    " 对满足pattern的结果进行格式化
    if a:firstline == a:lastline
        let firstline = 1
        let lastline = line('$')
    else
        let firstline = a:firstline
        let lastline = a:lastline + l:match_count
    endif
    let addlines = lastline - firstline
    let l:cmd_format = 'normal! ' . firstline. 'GV' . addlines . 'jgq'
    execute l:cmd_format
endfunction
nnoremap <leader>me :call Explode2P()<CR>
vnoremap <leader>me :call Explode2P()<CR>

" 为选中的Markdown文字加粗，bold
nnoremap <leader>mb viW"ms **** <Esc>hh"mPe
vnoremap <leader>mb "ms **** <Esc>hh"mPe
" 为选中的Markdown文字转为斜体，italic
nnoremap <leader>mi viW"ms____<Esc>h"mPe
vnoremap <leader>mi "ms____<Esc>h"mPe
" 为选中的内容添加链接，link
nnoremap <leader>ml viW<ESC>`>a]()<ESC>`<i[<ESC>`>4l
vnoremap <leader>ml <ESC>`>a]()<ESC>`<i[<ESC>`>4l
" 删除光标所在处的链接，link delete
nnoremap <leader>mld F[xf]xda(
" 为选中的内容添加图片链接，picture
nnoremap <leader>mp viW<ESC>`>a]()<ESC>`<i![<ESC>`>5l
vnoremap <leader>mp <ESC>`>a]()<ESC>`<i![<ESC>`>5l
" 删除光标所在处的图片链接，picture delete
nnoremap <leader>mpd F[h2xf]xda(

" Word Processor ----------------------------------------------------------{{{1

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

" FoldToggle --------------------------------------------------------------{{{1
set nofoldenable
set foldlevel=1 "低于或等于的折叠默认展开，高于此折叠级别的折叠会被关闭
" set foldclose=all " 用于光标移出后，自动关闭高于foldlevel的折叠。
" Vim光标所在处的折叠开关
" nnoremap <expr> <space> (foldlevel(line('.'))>0) ? "za" : "<space>"
" nnoremap <expr> <S-space> (foldlevel(line('.'))>0) ? "zA" : "<S-space>"
" nnoremap <M-space> zMzv
nnoremap <M-space> za
nnoremap <S-space> zMzv
" 切换是否显示foldcolumn
command! FoldColumnToggle call FoldColumnToggle()
function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=2
    endif
endfunction

" WikiGrep ----------------------------------------------------------------{{{1
" 搜索当前工作目录下的所有文件，但只搜索第一个匹配：
" Vim 8.1 及之前版本为每个文件一个匹配，Vim 8.2 变更为整个范围仅一个匹配
command! -nargs=1 WikiGrepBrief 1vimgrep /<args>/ **/*.md | copen 8
" 搜索当前工作目录下的所有文件的所有行，但只搜索每行的第一个匹配
command! -nargs=1 WikiGrepNormal vimgrep /<args>/ **/*.md | copen 8
" 搜索当前工作目录下的所有文件的所有行，且搜索每行的多个匹配
command! -nargs=1 WikiGrepVerbal vimgrep /<args>/g **/*.md | copen 8
" 采用Verbal模式搜索Tags
command! -nargs=1 WikiGrepTags vimgrep /:<args>:/g **/*.md | copen 8

" GoldenDict --------------------------------------------------------------{{{1
"nnoremap <c-c> <esc>muhebyiw`u
nnoremap <c-c> <esc>muyiw`u
"inoremap <c-c> <esc>muhebyiw`ua
inoremap <c-c> <esc>muyiw`ua
vnoremap <c-c> ygv

" VisualStar --------------------------------------------------------------{{{1
"用*或#对选中文字进行搜索
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

" nohlsearch --------------------------------------------------------------{{{1
" 清屏可以暂时关闭高亮
" nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR>:ccl<CR><C-l>
