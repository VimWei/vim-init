"===================================================
" GUI settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Essential --------------------------------------------------------------{{{1

if !has("gui_running")
    finish
endif

set guioptions-=m   "隐藏菜单
set guioptions-=T   "隐藏工具栏
set guioptions-=r   "隐藏右滚动条
set guioptions-=L   "隐藏垂直分割窗口的左滚动条
set guioptions-=e   "使用非 GUI 标签页行
set showtabline=2   "总是显示标签栏

set lines=18 columns=85    "非最大化时，窗口的高度和宽度
set guifont=Consolas:h14:cANSI:qDRAFT   "字体及大小
if !has('nvim')
    set renderoptions=type:directx,renmode:5    "增强显示
endif
set linespace=7    "行间距

" guifont++ --------------------------------------------------------------{{{1
"让vim像IDE一样一键放大缩小字号，M即Alt键
let guifontpp_size_increment=1 "每次更改的字号
let guifontpp_smaller_font_map="<M-Down>"
let guifontpp_larger_font_map="<M-Up>"
let guifontpp_original_font_map="<M-Home>"

" vimtweak ---------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Vimtweak.vim

" 切换窗口透明度
au GUIEnter * call libcallnr(g:vimtweak_dll_path, "SetAlpha", 230)
" <Leader>tw[0-9] 设置透明度程度，数字越大越透明
for i in range(0, 9)
    execute 'nnoremap <silent> <leader>tw' . i
          \ . ' :call libcallnr(g:vimtweak_dll_path, "SetAlpha", '
          \ . (255 - i * 10) . ')<CR>'
endfor

" 切换窗口的最大化状态
au GUIEnter * call libcallnr(g:vimtweak_dll_path, "EnableMaximize", 1)
nnoremap <silent> <leader>twm :call Vimtweak#ToggleWindowMaximize()<CR>

" 切换窗口的标题栏状态
" au GUIEnter * call libcallnr(g:vimtweak_dll_path, "EnableCaption", 0)
nnoremap <silent> <leader>twc :call Vimtweak#ToggleWindowCaption()<CR>

" 切换窗口的置顶状态
nnoremap <silent> <leader>twt :call Vimtweak#ToggleWindowTopMost()<CR>

" tabline ----------------------------------------------------------------{{{1
" 标签栏文字风格：默认为零，GUI 模式下空间大，按风格 3 显示
" 0: filename.txt +
" 1: 1-b1 - filename.txt +
" 2: [1-b1] filename.txt +
let g:config_vim_tab_style = 2
set tabline=%!Vim_NeatTabLine()
set guitablabel=%{Vim_NeatGuiTabLabel()}

" 终端下的 tabline  ------------------------------------------------------{{{2
function! Vim_NeatTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        let s .= '%' . (i + 1) . 'T'
        let s .= ' %{Vim_NeatTabLabel(' . (i + 1) . ')} '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'
    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999XX'
    endif

    return s
endfunc

" 需要显示到标签上的文件名  ---------------------------------------------{{{2
function! Vim_NeatBuffer(bufnr, fullname)
    let l:name = bufname(a:bufnr)
    if getbufvar(a:bufnr, '&modifiable')
        if l:name == ''
            return 'No Name'
        else
            if a:fullname
                return fnamemodify(l:name, ':p')
            else
                let aname = fnamemodify(l:name, ':p')
                let sname = fnamemodify(aname, ':t')
                if sname == ''
                    let test = fnamemodify(aname, ':h:t')
                    if test != ''
                        return '<'. test . '>'
                    endif
                endif
                return sname
            endif
        endif
    else
        let l:buftype = getbufvar(a:bufnr, '&buftype')
        if l:buftype == 'quickfix'
            return '[Quickfix]'
        elseif l:name != ''
            if a:fullname
                return '-'.fnamemodify(l:name, ':p')
            else
                return '-'.fnamemodify(l:name, ':t')
            endif
        else
        endif
        return '[No Name]'
    endif
endfunc

" 标签栏文字，使用 [1] filename 的模式  ----------------------------------{{{2
function! Vim_NeatTabLabel(n)
    let l:buflist = tabpagebuflist(a:n)
    let l:winnr = tabpagewinnr(a:n)
    let l:bufnr = l:buflist[l:winnr - 1]
    let l:fname = Vim_NeatBuffer(l:bufnr, 0)
    let l:num = a:n
    let l:bufnum = 'b'.l:bufnr
    let style = get(g:, 'config_vim_tab_style', 0)
    let l:tablabel = ''
    if style == 0
        let l:tablabel = l:fname
    elseif style == 1
        let l:tablabel = l:num." - ".l:bufnum." - ".l:fname
    elseif style == 2
        let l:tablabel = "[".l:num."-".l:bufnum."] ".l:fname
    endif
    if getbufvar(l:bufnr, '&modified') | let l:tablabel .= ' +' | endif
    return l:tablabel
endfunc

" GUI 下的标签文字，使用 [1] filename 的模式  ----------------------------{{{2
function! Vim_NeatGuiTabLabel()
    let l:num = v:lnum
    let l:buflist = tabpagebuflist(l:num)
    let l:winnr = tabpagewinnr(l:num)
    let l:bufnr = l:buflist[l:winnr - 1]
    let l:fname = Vim_NeatBuffer(l:bufnr, 0)
    let l:bufnum = 'b'.l:bufnr
    let style = get(g:, 'config_vim_tab_style', 0)
    let l:tablabel = ''
    if style == 0
        let l:tablabel = l:fname
    elseif style == 1
        let l:tablabel = l:num." - ".l:bufnum." - ".l:fname
    elseif style == 2
        let l:tablabel = "[".l:num."-".l:bufnum."] ".l:fname
    endif
    if getbufvar(l:bufnr, '&modified') | let l:tablabel .= ' +' | endif
    return l:tablabel
endfunc
