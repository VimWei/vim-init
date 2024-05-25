" https://www.github.com/benknoble/vim-auto-origami
" :help auto-origami

augroup auto_origami
    au!
    au CursorHold,BufWinEnter,WinEnter * AutoOrigamiFoldColumn
augroup END
