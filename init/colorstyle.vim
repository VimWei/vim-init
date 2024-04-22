"===================================================
" ColorScheme settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Default colorscheme ----------------------------------------------------{{{1
if has('termguicolors')
    set termguicolors
endif

" colorscheme lucius
" exe (strftime('%H') % 18) >= 6 ? 'LuciusLightHighContrast' : 'LuciusDarkLowContrast'

if !exists('s:default_colorscheme')
    let s:default_colorscheme = []
    let s:default_colorscheme += ['quiet']
    " let s:default_colorscheme += ['eclipse']
    " let s:default_colorscheme += ['delek']
    " let s:default_colorscheme += ['lucius']
    " let s:default_colorscheme += ['gaea']
endif
if empty(s:default_colorscheme)
    " 如果不指定，则从FavoriteScheme中选随机一个
    call Color#RandomFavoriteScheme()
else
    " 如果指定1至多个colorscheme，则从 s:default_colorscheme 中随机选一个
    let s:color_index = rand() % len(s:default_colorscheme)
    call Color#RandomFavoriteScheme(s:default_colorscheme[s:color_index])
endif

" Random colorscheme ------------------------------------------------------{{{1
" 详情查阅 ../autoload/Color.vim
nnoremap <silent> <Leader>c :call Color#RandomColorScheme()<CR>:color<CR>
