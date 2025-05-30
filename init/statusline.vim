"===================================================
" Statusline settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Statusline -------------------------------------------------------------{{{1
if has('nvim-0.7.0')
    set laststatus=3    " Global Statusline
else
    set laststatus=2    " 总是显示状态栏，但每个窗口一个 Statusline
endif

set statusline=                                 " 清空状态
set statusline+=%(\ %{CurrentMode()}\ \|\ %)    " Mode：INSERT/NORMAL/VISUAL
set statusline+=%(%{BufferWinInfo()}\ \|\ %)    " Info：buffer number, winnr
set statusline+=%f%(\ %m%)                      " 文件名(相对路径)及编辑状态
set statusline+=%(\ \|\ %{g:Git_status()}%)     " git 状态
set statusline+=%=\ %<                          " 向右对齐，且窗口较小时开启截短
set statusline+=%(%{tolower(&filetype)}\ \|\ %) " 文件类型
" 最右边显示文件格式、编码和行号等信息，并且固定在一个 group 中，优先占位
set statusline+=%0(%{&fileformat}\ \|\ %{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}\ \|\ %v:%l/%L=%p%%\ %)

" 返回当前模式的名称 -----------------------------------------------------{{{2
function! CurrentMode()
    let l:mode_map = {
                \ 'n': 'NORMAL',
                \ 'no': 'N·OPERATOR PENDING',
                \ 'v': 'VISUAL',
                \ 'V': 'V·LINE',
                \ "\<C-V>": 'V·BLOCK',
                \ 's': 'SELECT',
                \ 'S': 'S·LINE',
                \ "\<C-S>": 'S·BLOCK',
                \ 'i': 'INSERT',
                \ 'R': 'REPLACE',
                \ 'Rv': 'V·REPLACE',
                \ 'c': 'COMMAND',
                \ 'cv': 'VIM EX',
                \ 'ce': 'EX',
                \ 'r': 'PROMPT',
                \ 'rm': 'MORE',
                \ 'r?': 'CONFIRM',
                \ '!': 'SHELL',
                \ 't': 'TERMINAL'
                \ }
    let l:mode = mode(1)
    if winwidth(0) > 70
        return get(l:mode_map, l:mode, 'UNKNOWN')
    elseif winwidth(0) > 35
        return l:mode
    else
        return ''
    endif
endfunction

" 显示 buffer 号和窗口号 -------------------------------------------------{{{2
function! BufferWinInfo()
    if winwidth(0) > 50
        return 'b' . bufnr('%') . 'w' . winnr()
    else
        return ''
    endif
endfunction

" Tabline ----------------------------------------------------------------{{{1
" 标签栏文字风格：默认为零，GUI 模式下空间大，按风格 3 显示
" 0: filename.txt +
" 1: 1-b1 - filename.txt +
" 2: [1-b1] filename.txt +
let g:config_vim_tab_style = 2
set tabline=%!Vim_NeatTabLine()
if !has('nvim-0.11')
    set guitablabel=%{Vim_NeatGuiTabLabel()}
endif
" Always Show Tabline
set showtabline=2

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
        " let s .= '%=%#TabLine#%999XX'
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
    let l:num = a:n
    let l:buflist = tabpagebuflist(a:n)
    let l:winnr = tabpagewinnr(a:n)
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

" Tabpanel ---------------------------------------------------------------{{{1
if !has('nvim') && has('patch-9.1.1391')
    set tabpanelopt=columns:30,align:left
    set tabpanel=%!TabPanel()
    function! TabPanel() abort
        " return printf("[%1d] %%f", g:actual_curtabpage)
        let l:num = g:actual_curtabpage
        let l:buflist = tabpagebuflist(l:num)
        let l:winnr = tabpagewinnr(l:num)
        let l:bufnr = l:buflist[l:winnr - 1]
        let l:fname = Vim_NeatBuffer(l:bufnr, 0)
        let l:bufnum = 'b'.l:bufnr
        let l:tabpanel = ''
        let l:tabpanel = "[".l:num."-".l:bufnum."] ".l:fname
        if getbufvar(l:bufnr, '&modified') | let l:tabpanel .= ' +' | endif
        return l:tabpanel
    endfunction
    function! ToggleTabPanel() abort
        if &showtabpanel == 1
            set showtabpanel=0
            set showtabline=2
        else
            set showtabpanel=1
            set showtabline=0
        endif
    endfunction
    nnoremap <leader>tp :call ToggleTabPanel()<CR>
endif
