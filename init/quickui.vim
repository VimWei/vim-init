"===================================================
" quickui settings by W.Chen
" Sourced by: ../init.vim
"===================================================

if has('patch-8.2.1') == 0 || has('nvim')
    finish
endif

" 若修订后保存，则自动重新加载
if has("autocmd")
    let s:filepath = expand('<sfile>:p')
    if has('win32') || has('win64')
        let s:filepath = substitute(s:filepath, '\\', '/', 'g')
    endif
    let s:reload = 'autocmd! BufWritePost '.s:filepath.' source '.s:filepath
    execute s:reload . ' | echomsg "Reloaded"'
endif

" Navigator ---------------------------------------------------------------{{{1
" ref: https://github.com/skywind3000/vim-navigator?tab=readme-ov-file#configuration

" initialize global keymap and declare prefix key
let g:navigator = {'prefix':'\'}
let g:navigator_v = {'prefix':'\'}

" markdown
let g:navigator.m = {
    \ 'name' : '+Markdown',
    \ 'f' : [':set ft=markdown', '将文件类型设置为markdown'],
    \ 'e' : ['Explode2P()', '将全文的行转为段落 explode'],
    \ }

let g:navigator_v.m = {
    \ 'name' : '+Markdown',
    \ 'e' : ['Explode2P()', '将行转为段落 explode'],
    \ }

let g:navigator.g = {
    \ 'name' : '+Git',
    \ 'g' : [':Git', 'Summary window like git-status'],
    \ 'b' : [':Git blame %', '在行级显示文件的修改历史 :git blame %'],
    \ 'c' : [':Gcd', '切换目录到relative to the repository :Gcd'],
    \ 'd' : [':Git diff', '显示工作目录和暂存区之间的差异 :git diff'],
    \ 'e' : [':Git! difftool -y', 'git diff each changed file in a new tab'],
    \ 'f' : [':Git diff --staged', '显示暂存区和上一次提交之间的差异 :git diff --staged'],
    \ 'm' : [':Gdiffsplit!', '在处理冲突合并时进行三向对比 :Gdiffsplit!'],
    \ 'o' : [':Git log --oneline', '显示提交历史记录，每个一行'],
    \ 'l' : [':Git pull', ':git pull'],
    \ 's' : [':Git push', ':git push'],
    \ 'q' : [':Gclog', '显示提交历史记录，加载到 quickfix'],
    \ }

" buffer management
let g:navigator.b = {
    \ 'name' : '+Buffer',
    \ 'd' : [':bd', 'delete-buffer'],
    \ 'f' : [':bfirst', 'first-buffer'],
    \ 'n' : [':bnext', 'next-buffer'],
    \ 'p' : [':bprevious', 'previous-buffer'],
    \ 'l' : [':blast', 'last-buffer'],
    \ '?' : [':Leaderf buffer', 'Leaderf b'],
    \ }

" tab management
let g:navigator.t = {
    \ 'name': '+Tab',
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

" vim help
let g:navigator.h = {
    \ 'name': '+Help',
    \ 'h' : [':tab help', '帮助文档'],
    \ 't' : [':tab help tutor', '初学者教程'],
    \ 's' : [':tab help summary', '帮助小结'],
    \ '0' : [':tab help helphelp', '如何使用帮助文档'],
    \ '1' : ['tab help index', '命令索引'],
    \ '2' : ['tab help quickref', '常用命令总览'],
    \ '3' : ['tab help function-list', '函数列表'],
    \ '4' : ['tab help tips', 'Vim 的各种窍门'],
    \ '5' : ['tab help pattern.txt', '模式'],
    \ '6' : ['tab help registers', '寄存器'],
    \ '7' : ['tab help eval', '表达式'],
    \ }

" tab management
let g:navigator.v = {
    \ 'name': '+VIMRC',
    \ 'v' : [':edit $MYVIMRC', 'VIMRC'],
    \ 'i' : ['TabeditInit()', 'init.vim'],
    \ 'u' : ['TabeditQuickUI()', 'quickui.vim'],
    \ }

" Vimwiki
let g:navigator.w = {
    \ 'name' : '+Vimwiki',
    \ 'a' : [':RS', 'Open RoadShow index'],
    \ 'b' : [':VimwikiIndex', 'Open VimWiki index'],
    \ 'c' : [':VimwikiTabIndex', 'Open VimWiki index in a new tab'],
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
        \ '6' : [':normal gll', '升高当前列表级别-->'],
        \ '7' : [':normal glh', '降低当前列表级别<--'],
        \ },
    \ 't' : {
        \ 'name' : '+Todo' ,
        \ '1' : [':VimwikiToggleListItem', '切换 Todo 完成状态 [ ] [X]'],
        \ '2' : [':VimwikiToggleRejectedListItem', '切换 Todo 启用状态 [ ] [-]'],
        \ '3' : [':normal gln', '增加 Done 的成熟度 [ ] [.] [o]'],
        \ '4' : [':normal glp', '降低 Done 的成熟度 [o] [.] [ ]'],
        \ '5' : [':VimwikiNextTask', '跳到下一个未完成的任务'],
        \ '6' : [':VimwikiRemoveSingleCB', '移除 Todo checkbox [ ]'],
        \ },
    \ }

let g:navigator.config = {
    \ 'icon_separator': '→',
    \ 'bracket': 1,
    \ 'spacing': 3,
    \ 'padding': [2,0,2,0],
    \ 'max_height': 20,
    \ 'min_height': 5,
    \ 'max_width': 60,
    \ 'min_width': 20,
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
vnoremap <silent>\ :NavigatorVisual g:navigator_v<cr>

" Menu --------------------------------------------------------------------{{{1
" ref: https://github.com/skywind3000/vim-quickui/blob/master/MANUAL.md

" clear all the menus
call quickui#menu#reset()

" install a 'File' menu, each item comprises its name and command to execute
call quickui#menu#install('&File', [
    \ [ "Quit", 'q', '退出'],
    \ [ "&Close window", 'close', '关闭窗口'],
    \ [ "Save all and Quit", 'wqa', '保存并退出'],
    \ [ "Quit without saving", 'q!', '不保存退出'],
    \ [ "--", '' ],
    \ [ "&Save", 'w', '保存'],
    \ [ "Save all", 'wa', '保存所有文件'],
    \ [ "Save &as", 'call feedkey("bro w")', '另存为...'],
    \ [ "--", '' ],
    \ [ "&New File", 'tabnew', '新建文档'],
    \ [ "&Open File", 'call feedkeys("bro edit")', '打开...'],
    \ ])

" items containing tips, tips will display in the cmdline
call quickui#menu#install("&Tools", [
    \ ["&Update plugins", "PlugUpdate", 'update plugins'],
    \ ["Upgrade vim-plug", "PlugUpgrade", 'upgrade vim-plug'],
    \ ["Plugin &List", "PlugStatus", 'list available plugins'],
    \ ["-"],
    \ ["Edit MENU", 'TU', '在新窗口编辑菜单'],
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
    \ ['Toggle Todo status done [ ] [X] ', 'VimwikiToggleListItem', '切换 Todo 完成状态'],
    \ ['Toggle Todo status Reject [ ] [-]', 'VimwikiToggleRejectedListItem', '切换 Todo 启用状态'],
    \ ['Increase done status [ ] [.] [o]', 'normal gln', '增加 Done 的成熟度'],
    \ ['Decrease done status [o] [.] [ ]', 'normal glp', '降低 Done 的成熟度'],
    \ ['Remove checkbox [ ] from list item', 'VimwikiRemoveSingleCB', '移除 Todo checkbox'],
    \ ['Find next unfinished task', 'VimwikiNextTask', '跳到下一个未完成的任务'],
    \ ["-"],
    \ ['Change Symbol To *', 'VimwikiChangeSymbolTo *', '更改当前列表符号为 gl*'],
    \ ['Change Symbol To -', 'VimwikiChangeSymbolTo -', '更改当前列表符号为 gl-'],
    \ ['Change Symbol To 1', 'VimwikiChangeSymbolTo 1.', '更改当前列表符号为 gl1'],
    \ ['Renumber list items', 'VimwikiRenumberList', '重建当前列表编号 glr'],
    \ ['Renumber All list items', 'VimwikiRenumberAllLists', '重建全文列表编号 glR'],
    \ ['Increase List Level -->', 'normal gll', '升高当前列表级别 gll'],
    \ ['Decrease List Level <--', 'normal glh', '降低当前列表级别 glh'],
    \ ["-"],
    \ ['Update diary index', 'VimwikiDiaryGenerateLinks', '更新Diary索引目录'],
    \ ["Rebuild Tags", 'VimwikiRebuildTags!', '重新生成Tags'],
    \ ], '<auto>', 'vimwiki')

" register HELP menu with weight 10000
call quickui#menu#install('&Help', [
    \ ["&Help", 'tab help', '帮助文档'],
    \ ["Help help", 'tab help helphelp', '如何使用帮助文档'],
    \ ["&Tutorial", 'tab help tutor', '初学者教程'],
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
