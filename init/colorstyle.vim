"===================================================
" ColorScheme settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Default colorscheme ----------------------------------------------------{{{1

if !exists('s:default_colorscheme')
    let s:default_colorscheme = []
    let s:default_colorscheme += ['quiet']
    " let s:default_colorscheme += ['lucius']
endif

if index(s:default_colorscheme, 'quiet') >= 0
    execute 'set background=' . ((strftime('%H') + 0) >= 6 ? 'light' : 'dark')
    colorscheme quiet
endif

if index(s:default_colorscheme, 'lucius') >= 0
    colorscheme lucius
    exe (strftime('%H') % 18) >= 6 ? 'LuciusLightHighContrast' : 'LuciusDarkLowContrast'
endif

" Random colorscheme ------------------------------------------------------{{{1
" 详情查阅 ../autoload/Color.vim
nnoremap <silent> <Leader>c :call Color#RandomColorScheme()<CR>:color<CR>
