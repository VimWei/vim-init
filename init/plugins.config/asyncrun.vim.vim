" https://www.github.com/skywind3000/asyncrun.vim

" set shell encoding if it's different from &encoding
let g:asyncrun_encs = 'gbk'
" open quickfix window at given height after command starts
let g:asyncrun_open = 8
" trim the empty lines in the quickfix window
let g:asyncrun_trim = 0
" Display Progress in Status Line
let g:asyncrun_status = "stopped"
" let g:asynctasks_term_focus = 1
augroup QuickfixStatus
    au! BufWinEnter quickfix setlocal
                \ statusline=%t\ [%{g:asyncrun_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P
augroup END
