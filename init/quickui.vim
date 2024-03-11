"===================================================
" quickui settings by W.Chen
" Sourced by: ../init.vim
"===================================================

if has('patch-8.2.1') == 0 || has('nvim')
    finish
endif

" Menu --------------------------------------------------------------------{{{1

" clear all the menus
call quickui#menu#reset()

" install a 'File' menu, each item comprises its name and command to execute
call quickui#menu#install('&File', [
    \ [ "&New File", 'tabnew', '新建文档'],
    \ [ "&Open File", 'call feedkeys(":bro edit")', '打开...'],
    \ [ "&Close", 'close', '关闭当前窗口'],
    \ [ "--", '' ],
    \ [ "&Save", 'w', '保存'],
    \ [ "Save &as", 'call feedkey(":bro w")', '另存为...'],
    \ [ "Save all", 'wa', '保存所有文件'],
    \ [ "--", '' ],
    \ [ "Quit", 'q', '退出'],
    \ [ "Quit without saving", 'q!', '不保存退出'],
    \ [ "Save all and Quit", 'waq!', '保存并退出'],
    \ ])

" items containing tips, tips will display in the cmdline
call quickui#menu#install("&Tools", [
    \ ["&Update plugins", "PlugUpdate", 'update plugins'],
    \ ["Upgrade vim-plug", "PlugUpgrade", 'upgrade vim-plug'],
    \ ["Plugin &List", "PlugStatus", 'list available plugins'],
    \ ["-"],
    \ ["Edit MENU", 'TM', '在新窗口编辑菜单'],
    \ ["Edit VIMRC", 'TV', '在新窗口编辑VIMRC'],
    \ ])

" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("&Option", [
    \ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!', 'Toggle spell check %{&spell? "off" : "on"}'],
    \ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!', 'Toggle cursor line %{&cursorline? "off" : "on"}'],
    \ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!', 'Toggle paste mode %{&paste? "off" : "on"}'],
    \ ["-"],
    \ ["Options help", 'tab help options', '关于 options 的帮助文档'],
    \ ])

" register HELP menu with weight 10000
call quickui#menu#install('&Help', [
    \ ["&Help", 'tab help', '帮助文档'],
    \ ["Help help", 'tab help help', '如何使用帮助文档'],
    \ ["&Tutorial", 'tab help tutor', '初学者交互式教程'],
    \ ['&Summary', 'tab help summary', '帮助小结'],
    \ ['--',''],
    \ ["&Cheatsheet", 'tab help index', '命令索引'],
    \ ['&Quick Reference', 'tab help quickref', '常用命令总览'],
    \ ['&Function List', 'tab help function-list', '函数列表'],
    \ ['T&ips', 'tab help tips', 'Vim 的各种窍门'],
    \ ['--',''],
    \ ["&Pattern", 'tab help pattern.txt', '模式'],
    \ ["&Registers", 'tab help registers', '寄存器'],
    \ ['&Vim Script', 'tab help eval', '表达式'],
    \ ], 10000)

let g:quickui_show_tip = 1
let g:quickui_border_style = 1
" availabe color scheme：borland、gruvbox、solarized、papercol dark、papercol light
let g:quickui_color_scheme = 'borland'

" hit space twice to open menu
" multiple menu namespaces: https://github.com/skywind3000/vim-quickui/wiki/Menu-Namespaces
" The default menus is located in the system namespace.
noremap <Leader><Leader>m :call quickui#menu#open()<cr>

" Custom Command ----------------------------------------------------------{{{1

command! RS call RoadShowIndex()
function! RoadShowIndex()
    execute "VimwikiTabIndex"
    execute "find Research\\路演.md"
endfunction

" Navigator ---------------------------------------------------------------{{{1

" initialize global keymap and declare prefix key
let g:navigator = {'prefix':'\'}

let g:navigator.m = [':call quickui#menu#open()', 'Open Menu']

" Vimwiki
let g:navigator.w = {
            \ 'name' : '+vimwiki' ,
            \ '0' : [':VimwikiTabIndex', 'Open VimWiki index in a new tab'],
            \ '1' : [':VimwikiMakeDiaryNote', 'Open today diary'],
            \ '2' : [':VimwikiTabMakeDiaryNote', 'Open today diary in a new tab'],
            \ '3' : [':VimwikiMakeYesterdayDiaryNote', 'Open yesterday diary'],
            \ '4' : [':VimwikiMakeTomorrowDiaryNote', 'Open tomorrow diary'],
            \ '5' : [':VimwikiDiaryNextDay', 'Open next day diary'],
            \ '6' : [':VimwikiDiaryPrevDay', 'Open previous day diary'],
            \ '7' : [':VimwikiDeleteFile', 'Delete wiki page'],
            \ '8' : [':VimwikiRenameFile', 'Rename wiki page'],
            \ 'r' : [':RS', 'Open RoadShow index'],
            \ 'i' : [':VimwikiDiaryIndex', 'Open diary index file'],
            \ 'w' : [':VimwikiIndex', 'Open VimWiki index'],
            \ }

" buffer management
let g:navigator.b = {
            \ 'name' : '+buffer' ,
            \ '1' : [':b1'        , 'buffer 1']        ,
            \ '2' : [':b2'        , 'buffer 2']        ,
            \ 'd' : [':bd'        , 'delete-buffer']   ,
            \ 'f' : [':bfirst'    , 'first-buffer']    ,
            \ 'n' : [':bnext'     , 'next-buffer']     ,
            \ 'p' : [':bprevious' , 'previous-buffer'] ,
            \ 'l' : [':blast'     , 'last-buffer']     ,
            \ '?' : [':Leaderf buffer'   , 'Leaderf b']      ,
            \ }

" tab management
let g:navigator.t = {
            \ 'name': '+tab',
            \ '1' : ['<key>1gt', 'tab-1'],
            \ '2' : ['<key>2gt', 'tab-2'],
            \ '3' : ['<key>3gt', 'tab-3'],
            \ 'c' : [':tabnew', 'new-tab'],
            \ 'q' : [':tabclose', 'close-current-tab'],
            \ 'n' : [':tabnext', 'next-tab'],
            \ 'p' : [':tabprev', 'previous-tab'],
            \ 'o' : [':tabonly', 'close-all-other-tabs'],
            \ }

" let g:navigator.config = {
"     \ 'icon_separator': '→',
"     \ 'popup': 1,
"     \ 'popup_position': 'center',
"     \ 'popup_width': 60,
"     \ 'popup_height': 5,
"     \ }

nnoremap <silent>\ :Navigator g:navigator<cr>
