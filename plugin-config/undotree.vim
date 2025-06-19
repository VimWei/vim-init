" https://www.github.com/mbbill/undotree

nnoremap <Leader>u :UndotreeToggle<CR>
" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    if has('nvim')
        let s:undotree_dir = expand('~/.local/share/nvim/undodir')
    else
        let s:undotree_dir = expand('~/vimfiles/undodir')
    endif
    if !isdirectory(s:undotree_dir)
        call mkdir(s:undotree_dir, "p", 0700)
    endif
    let g:undotree_UndoDir = s:undotree_dir
    let &undodir = g:undotree_UndoDir
    set undofile
endif
let g:undotree_WindowLayout = 3
let g:undotree_ShortIndicators  = 1
