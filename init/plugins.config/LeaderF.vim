" https://www.github.com/Yggdroot/LeaderF

let g:Lf_StlColorscheme = 'gruvbox_material'
let g:Lf_HideHelp = 1
let g:Lf_WindowHeight = 0.30
let g:Lf_ShowDevIcons = 0
let g:Lf_PreviewInPopup = 1
"F - if the current working directory is not the direct ancestor of current
"    file, use the directory of the current file as LeaderF's working
"    directory, otherwise, use the current working directory.
let g:Lf_WorkingDirectoryMode = 'F'
let g:Lf_WildIgnore = {
    \ 'dir': ['.svn','.git','.hg'],
    \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.zip']
    \}

let g:Lf_ShortcutF = '<leader>f'
let g:Lf_ShortcutB = '<leader>fb'
noremap <leader>fm :<C-U>Leaderf mru<CR>
noremap <leader>fl :Leaderf line --regexMode<CR>
noremap <leader>fc :Leaderf line --regexMode --input \(\s\+\)\@<!\_^#\+\s\+.*<CR>
noremap <leader>ft :<C-U>Leaderf tag --regexMode<CR>
noremap <leader>fh :<C-U>Leaderf help<CR>
noremap <leader>fg :<C-U><C-R>=printf("Leaderf rg %s", "")<CR>
noremap <leader>fr :<C-U>Leaderf! --recall<CR>
noremap <leader>fs :<C-U>Leaderf! self<CR>
noremap ]f :<C-U>Leaderf --next<CR>
noremap [f :<C-U>Leaderf --previous<CR>
