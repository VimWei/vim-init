"===================================================
" ColorScheme settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Default colorscheme ----------------------------------------------------{{{1
if has('termguicolors')
    set termguicolors
endif

colorscheme lucius
exe (strftime('%H') % 18) >= 6 ? 'LuciusLightHighContrast' : 'LuciusDarkLowContrast'

" Random colorscheme ------------------------------------------------------{{{1
" 详情查阅 ../autoload/Color.vim
nnoremap <silent> <Leader>c :call Color#RandomColorScheme()<CR>:color<CR>
