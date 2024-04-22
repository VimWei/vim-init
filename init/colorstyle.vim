"===================================================
" ColorScheme settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Default colorscheme ----------------------------------------------------{{{1
if has('termguicolors')
    set termguicolors
endif

if !exists('s:default_colorscheme')
    let s:default_colorscheme = []
    let s:default_colorscheme += ['quiet']
    " let s:default_colorscheme += ['xcode']
    " let s:default_colorscheme += ['lucius']
    " let s:default_colorscheme += ['gaea']
    let s:default_colorscheme += ['eclipse']
    let s:default_colorscheme += ['delek']
endif

if empty(s:default_colorscheme)
    " 如果不指定，则从RandomFavoriteScheme中随机一个
    call Color#RandomFavoriteScheme()
else
    " 如果指定1至多个colorscheme，则从中随机选一个
    let s:color_index = rand() % len(s:default_colorscheme)
endif

if s:default_colorscheme[s:color_index] == 'quiet'
    execute 'set background=' . ((strftime('%H') + 0) >= 6 ? 'light' : 'dark')
    colorscheme quiet
elseif s:default_colorscheme[s:color_index] == 'xcode'
    execute 'set background=' . ((strftime('%H') + 0) >= 6 ? 'light' : 'dark')
    colorscheme xcodehc
elseif s:default_colorscheme[s:color_index] == 'lucius'
    colorscheme lucius
    exe (strftime('%H') % 18) >= 6 ? 'LuciusLightHighContrast' : 'LuciusDarkLowContrast'
else
    " 对于无特定要求的colorscheme，则执行RandomFavoriteScheme中的定义
    call Color#RandomFavoriteScheme(s:default_colorscheme[s:color_index])
endif

" Random colorscheme ------------------------------------------------------{{{1
" 详情查阅 ../autoload/Color.vim
nnoremap <silent> <Leader>c :call Color#RandomColorScheme()<CR>:color<CR>
