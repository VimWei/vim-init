"===================================================
" ColorScheme settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Random colorscheme -----------------------------------------------------{{{1
" 详情查阅 ../autoload/Color.vim
nnoremap <silent> <Leader>ca :call Color#RandomColorScheme()<CR>:color<CR>
nnoremap <silent> <Leader>cc :call Color#RandomFavoriteScheme()<CR>:color<CR>

" Default colorscheme ----------------------------------------------------{{{1
if has('termguicolors')
    set termguicolors
endif

if !exists('s:default_colorscheme')
    let s:default_colorscheme = []
    let s:default_colorscheme += ['delek']
    let s:default_colorscheme += ['eclipse']
    if !has('nvim')
        let s:default_colorscheme += ['retrobox']
    endif
endif
if empty(s:default_colorscheme)
    " 如果不指定，则从FavoriteScheme中选随机一个
    call Color#RandomFavoriteScheme()
else
    " 如果指定1至多个colorscheme，则从 s:default_colorscheme 中随机选一个
    let s:color_index = rand() % len(s:default_colorscheme)
    call Color#RandomFavoriteScheme(s:default_colorscheme[s:color_index])
endif

" Which Color ------------------------------------------------------------{{{1
" Find out to which highlight-group a particular keyword/symbol belongs
command! WhichColor echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") .
    \ "> trans<" . synIDattr(synID(line("."),col("."),0),"name") .
    \ "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") .
    \ "> fg:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")

finish " -----------------------------------------------------------------{{{1

colorscheme lucius
exe (strftime('%H') % 18) >= 6 ? 'LuciusLightHighContrast' : 'LuciusDarkLowContrast'
