"===================================================
" GUI/Terminal style settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Non-GUI settings -------------------------------------------------------{{{1
" Terminal cursor shape, Neovide config — only relevant outside gvim.
if !has("gui_running")
    " Terminal cursor shape ----------------------------------------------{{{2
    " Match gvim behavior: block in normal mode, I-beam in insert mode
    if has('nvim')
        set guicursor=n-v-c:block-Cursor,i-ci-ve:ver25-Cursor2,r-cr:hor20,o:hor20
        set guicursor+=n-v-c:blinkon0,i-ci:blinkon0
    elseif has('win32')
        " Windows Console API may not forward cursor shape VT sequences
        " through ConPTY to Windows Terminal.  Use ctypes (Python) or
        " PowerShell to write them directly to the console handle.
        if has('python3') && get(g:, 'python_available', v:false)
            py3 << EOF
import ctypes, vim
_k32 = ctypes.windll.kernel32
_STD_OUT = -11
def _set_cursor_shape(mode):
    code = '6' if mode == 'i' else '2'
    seq = f'\x1b[{code} q'.encode()
    h = _k32.GetStdHandle(_STD_OUT)
    w = ctypes.c_ulong(0)
    _k32.WriteFile(h, seq, len(seq), ctypes.byref(w), None)
EOF
            function! s:CursorShape(mode)
                py3 _set_cursor_shape(vim.eval('a:mode'))
            endfunction
        elseif executable('powershell')
            function! s:CursorShape(mode)
                let l:code = a:mode ==# 'i' ? '6' : '2'
                let l:cmd = printf('!powershell -NoP -C "[Console]::Out.Write([char]27+''[%s q'')"', l:code)
                silent execute l:cmd
            endfunction
        endif

        if exists('*s:CursorShape')
            augroup CursorShapeWin
                autocmd!
                autocmd VimEnter,BufEnter,InsertLeave,CmdlineLeave,CursorMoved * call timer_start(0, {-> s:CursorShape('n')})
                autocmd InsertEnter * call timer_start(0, {-> s:CursorShape('i')})
            augroup END
        endif
    else
        " Linux/macOS: t_SI/t_EI work via standard PTY
        let &t_SI = "\e[5 q"  " I-beam (vertical bar)
        let &t_SR = "\e[4 q"  " Underline
        let &t_EI = "\e[2 q"  " Block (steady block)
    endif

    " Neovide ------------------------------------------------------------{{{2
    " 详情查阅 ../autoload/Neovide.vim
    if exists("g:neovide")
        let g:neovide_underline_stroke_scale = 0.1
        let g:neovide_scroll_animation_length = 0.13
        let g:neovide_cursor_trail_size = 0.3

        let g:neovide_opacity = 0.9
        for i in range(0, 9)
            execute 'nnoremap <silent> <leader>tw' . i
                \ . ' :let g:neovide_opacity = '
                \ . (1 - i * 0.1) . '<CR>'
        endfor
        let g:neovide_fullscreen = v:false

        nnoremap <leader>twc :call Neovide#ToggleFullscreen()<CR>
    endif

    finish
endif

" GUI-only settings ------------------------------------------------------{{{1

set guioptions-=m   "隐藏菜单
set guioptions-=T   "隐藏工具栏
set guioptions-=r   "隐藏右滚动条
set guioptions-=L   "隐藏垂直分割窗口的左滚动条
set guioptions-=e   "使用非 GUI 标签页行
set showtabline=2   "总是显示标签栏

set lines=18 columns=85    "非最大化时，窗口的高度和宽度
set guifont=Consolas:h14:cANSI:qDRAFT   "字体及大小
set linespace=7    "行间距

if !has('nvim')
    set renderoptions=type:directx,renmode:5    "增强显示
endif
