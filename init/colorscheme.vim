"===================================================
" ColorScheme settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Basic Setting -----------------------------------------------------------{{{1

" 设置常用 colorescheme 的调用命令
" 通过命令 color + tab 快速切换常用样式
command! ColorNord colorscheme nord
command! ColorGruvbox colorscheme gruvbox
command! ColorLandscape colorscheme landscape
command! ColorLuciusDark LuciusDarkLowContrast
command! ColorLuciusLight LuciusLightHighContrast

" default colorscheme
colorscheme lucius
"Change theme depending on the time of day
exe (strftime('%H') % 18) >= 6 ? 'LuciusLightHighContrast' : 'LuciusDarkLowContrast'

finish
