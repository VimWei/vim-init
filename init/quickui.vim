"===================================================
" quickui settings by W.Chen
" Sourced by: ../init.vim
"===================================================

if has('patch-8.2.1') == 0 || has('nvim')
    finish
endif

" Menu --------------------------------------------------------------------{{{1
" ref: https://github.com/skywind3000/vim-quickui/blob/master/MANUAL.md

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

" Vimwiki
call quickui#menu#install("&Vimwiki", [
    \ ['Toggle Todo status done [ ] [X] ', 'VimwikiToggleListItem', '切换列表的 Todo 状态'],
    \ ['Increase done status [ ] [.] [o]', 'normal gln', '增加 Done 的成熟度'],
    \ ['Decrease done status [o] [.] [ ]', 'normal glp', '降低 Done 的成熟度'],
    \ ['Toggle Todo status Reject [ ] [-]', 'VimwikiToggleRejectedListItem', '切换 Todo 启用状态'],
    \ ['Find next unfinished task', 'VimwikiNextTask', '跳到下一个未完成的任务'],
    \ ['Remove checkbox [ ] from list item', 'VimwikiRemoveSingleCB', '移除 Todo checkbox'],
    \ ["-"],
    \ ['Change Symbol To *', 'VimwikiChangeSymbolTo *', '更改当前列表符号为 gl*'],
    \ ['Change Symbol To -', 'VimwikiChangeSymbolTo -', '更改当前列表符号为 gl-'],
    \ ['Change Symbol To 1', 'VimwikiChangeSymbolTo 1.', '更改当前列表符号为 gl1'],
    \ ['Renumber list items', 'VimwikiRenumberList', '重建当前列表编号 glr'],
    \ ['Renumber All list items', 'VimwikiRenumberAllLists', '重建全文列表编号 glR'],
    \ ['Increase List Level', 'normal gll', '升高当前列表级别 gll'],
    \ ['Decrease List Level', 'normal glh', '降低当前列表级别 glh'],
    \ ["-"],
    \ ['Update diary index', 'VimwikiDiaryGenerateLinks', '更新Diary索引目录'],
    \ ["Rebuild Tags", 'VimwikiRebuildTags!', '重新生成Tags'],
    \ ], '<auto>', 'vimwiki')

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
let g:quickui_border_style = 2
" availabe color scheme：borland、gruvbox、solarized、papercol dark、papercol light
let g:quickui_color_scheme = 'gruvbox'

" open menu
" multiple menu namespaces: https://github.com/skywind3000/vim-quickui/wiki/Menu-Namespaces
" The default menus is located in the system namespace.
noremap <Leader><Leader>m :call quickui#menu#open()<cr>

" Navigator ---------------------------------------------------------------{{{1
" ref: https://github.com/skywind3000/vim-navigator?tab=readme-ov-file#configuration

" initialize global keymap and declare prefix key
let g:navigator = {'prefix':'\'}

let g:navigator.m = [':call quickui#menu#open()', 'Open Menu']

" buffer management
let g:navigator.b = {
    \ 'name' : '+buffer',
    \ 'd' : [':bd', 'delete-buffer'],
    \ 'f' : [':bfirst', 'first-buffer'],
    \ 'n' : [':bnext', 'next-buffer'],
    \ 'p' : [':bprevious', 'previous-buffer'],
    \ 'l' : [':blast', 'last-buffer'],
    \ '?' : [':Leaderf buffer', 'Leaderf b'],
    \ }

" tab management
let g:navigator.t = {
    \ 'name': '+tab',
    \ 'c' : [':tabnew', 'New tab'],
    \ 't' : [':tab split', 'Split in new tab'],
    \ 'l' : ['Tab_MoveRight()', 'Move tab to right'],
    \ 'h' : ['Tab_MoveLeft()', 'Move tab to Left'],
    \ 'q' : [':tabclose', 'Close current tab'],
    \ 'o' : [':tabonly', 'Close all other tabs'],
    \ 'n' : [':tabnext', 'Next tab'],
    \ 'p' : [':tabprev', 'Previous tab'],
    \ '0' : [':0tabmove', 'Move tab to the begin'],
    \ '$' : [':tabmove', 'Move tab to the last'],
    \ }

" tab management
let g:navigator.v = {
    \ 'name': '+VIMRC',
    \ 'v' : [':edit $MYVIMRC', 'VIMRC'],
    \ 'i' : ['TabeditInit()', 'init.vim'],
    \ 'm' : ['TabeditMenu()', 'quickui.vim'],
    \ }

" Vimwiki
let g:navigator.w = {
    \ 'name' : '+Vimwiki',
    \ 'w' : [':VimwikiIndex', 'Open VimWiki index'],
    \ 'v' : [':VimwikiTabIndex', 'Open VimWiki index in a new tab'],
    \ 'r' : [':RS', 'Open RoadShow index'],
    \ 'x' : [':VimwikiDeleteFile', 'Delete wiki page'],
    \ 'y' : [':VimwikiRenameFile', 'Rename wiki page'],
    \ 'z' : [':VimwikiRebuildTags!', 'Rebuild Tags after deleted'],
    \ 'd' : {
        \ 'name' : '+Dairy',
        \ '0' : [':VimwikiDiaryIndex', 'Open diary index file'],
        \ '1' : [':VimwikiMakeDiaryNote', 'Open today diary'],
        \ '2' : [':VimwikiTabMakeDiaryNote', 'Open today diary in a new tab'],
        \ '3' : [':VimwikiMakeYesterdayDiaryNote', 'Open yesterday diary'],
        \ '4' : [':VimwikiMakeTomorrowDiaryNote', 'Open tomorrow diary'],
        \ '5' : [':VimwikiDiaryNextDay', 'Open next day diary'],
        \ '6' : [':VimwikiDiaryPrevDay', 'Open previous day diary'],
        \ 'u' : [':VimwikiDiaryGenerateLinks', 'Update diary index'],
        \ 't' : ['<key>a<C-R>=strftime("%Y-%m-%d %A %H:%M:%S")<CR><Esc>', 'Insert datetime'],
        \ },
    \ 'l' : {
        \ 'name' : '+List',
        \ '1' : [':VimwikiChangeSymbolTo *', '更改当前列表符号为 *'],
        \ '2' : [':VimwikiChangeSymbolTo -', '更改当前列表符号为 -'],
        \ '3' : [':VimwikiChangeSymbolTo 1.', '更改当前列表符号为 1'],
        \ '4' : [':VimwikiRenumberList', '重建当前列表编号'],
        \ '5' : [':VimwikiRenumberAllLists', '重建全文列表编号'],
        \ '6' : [':normal gll', '升高当前列表级别'],
        \ '7' : [':normal glh', '降低当前列表级别'],
        \ },
    \ 't' : {
        \ 'name' : '+Todo' ,
        \ '1' : [':VimwikiToggleListItem', '切换列表的 Todo 状态 [ ] [X]'],
        \ '2' : [':normal gln', '增加 Done 的成熟度 [ ] [.] [o]'],
        \ '3' : [':normal glp', '降低 Done 的成熟度 [o] [.] [ ]'],
        \ '4' : [':VimwikiToggleRejectedListItem', '切换 Todo 启用状态 [ ] [-]'],
        \ '5' : [':VimwikiNextTask', '跳到下一个未完成的任务'],
        \ '6' : [':VimwikiRemoveSingleCB', '移除 Todo checkbox [ ]'],
        \ },
    \ }

let g:navigator.config = {
    \ 'icon_separator': '→',
    \ 'bracket': 1,
    \ 'spacing': 3,
    \ 'padding': [2,0,2,0],
    \ 'max_height': '8',
    \ 'min_height': '5',
    \ 'max_width': '60',
    \ 'min_width': '20',
    \ 'vertical': 0,
    \ 'position': 'top',
    \ 'fallback': 0,
    \ 'popup': 0,
    \ 'popup_position': 'center',
    \ 'popup_width': '60%',
    \ 'popup_height': '20%',
    \ 'popup_border': 1,
    \ 'char_display': {},
    \ }

nnoremap <silent>\ :Navigator g:navigator<cr>

finish
