" https://www.github.com/skywind3000/vim-quickui
" manual: https://github.com/skywind3000/vim-quickui/blob/master/MANUAL.md
" multiple menu namespaces: https://github.com/skywind3000/vim-quickui/wiki/Menu-Namespaces

" clear all the menus ----------------------------------------------------{{{1
call quickui#menu#reset()

" File -------------------------------------------------------------------{{{1
call quickui#menu#install('&File', [
    \ [ "Quit", 'q', '退出'],
    \ [ "&Close window", 'close', '关闭窗口'],
    \ [ "Save all and Quit", 'wqa', '保存并退出'],
    \ [ "Quit without saving", 'q!', '不保存退出'],
    \ [ "--", '' ],
    \ [ "&Save", 'w', '保存'],
    \ [ "Save &all", 'wa', '保存所有文件'],
    \ [ "Save as", 'bro w', '另存为...'],
    \ [ "--", '' ],
    \ [ "&New File", 'tabnew', '新建文档'],
    \ [ "&Open File", 'bro edit', '打开...'],
    \ ])

" Tools ------------------------------------------------------------------{{{1
call quickui#menu#install("&Tools", [
    \ ["&Update VIMRC", "call Vimrc#Update()", 'update VIMRC'],
    \ ["&Edit VIMRC", 'VI', '在新窗口编辑VIMRC'],
    \ ["-"],
    \ ["Edit &Menu", 'VM', '在新窗口编辑菜单'],
    \ ["Edit &Navigator", 'VN', '在新窗口编辑导航'],
    \ ["-"],
    \ ["Update &plugins", "PlugUpdate", 'update plugins'],
    \ ["Upgrade &vim-plug", "PlugUpgrade", 'upgrade vim-plug'],
    \ ["Plugin &List", "PlugStatus", 'list available plugins'],
    \ ])

" Option -----------------------------------------------------------------{{{1
" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("&Option", [
    \ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!', 'Toggle spell check %{&spell? "off" : "on"}'],
    \ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!', 'Toggle cursor line %{&cursorline? "off" : "on"}'],
    \ ["-"],
    \ ["Options help", 'tab help options', '关于 options 的帮助文档'],
    \ ])

" Markdown ---------------------------------------------------------------{{{1
if IsInPlugGroup('Notetaking', 'vimwiki')
    call quickui#menu#install("&Markdown", [
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
        \ ['Increase List Level -->', 'normal gll', '降低当前列表级别 gll'],
        \ ['Decrease List Level <--', 'normal glh', '升高当前列表级别 glh'],
        \ ["-"],
        \ ['Update diary index', 'VimwikiDiaryGenerateLinks', '更新Diary索引目录'],
        \ ["Rebuild Tags", 'VimwikiRebuildTags!', '重新生成Tags'],
        \ ], '<auto>', 'markdown')
endif

" List -------------------------------------------------------------------{{{1
call quickui#menu#install("&List", [
    \ ['Change Symbol To 1.', 'normal gl1', '更改当前列表符号为 1.'],
    \ ['Change Symbol To 1)', 'normal gl2', '更改当前列表符号为 1)'],
    \ ['Change Symbol To A.', 'normal glA', '更改当前列表符号为 A.'],
    \ ['Change Symbol To a)', 'normal gla', '更改当前列表符号为 a)'],
    \ ['Change Symbol To *', 'normal gl*', '更改当前列表符号为 *'],
    \ ['Change Symbol To -', 'normal gl-', '更改当前列表符号为 -'],
    \ ['Change Symbol To +', 'normal gl+', '更改当前列表符号为 +'],
    \ ["-"],
    \ ['Demote List Level -->', 'normal gl>', '降低当前列表级别 -->'],
    \ ['promote List Level <--', 'normal gl<', '提升当前列表级别 <--'],
    \ ['Renumber List Items', 'normal glr', '重建当前列表编号 renumber'],
    \ ['Delete List Symbol', 'normal gld', '删除当前列表编号 delete'],
    \ ])

" Help -------------------------------------------------------------------{{{1
call quickui#menu#install('&Help', [
    \ ["&Help", 'tab help', '帮助文档'],
    \ ["Help help", 'tab help helphelp', '如何使用帮助文档'],
    \ ["&Tutorial", 'tab help tutor', '初学者教程'],
    \ ['&Summary', 'tab help help-summary', '帮助小结'],
    \ ['--',''],
    \ ["&Cheatsheet", 'tab help index', '命令索引'],
    \ ['&Quick Reference', 'tab help quickref', '常用命令总览'],
    \ ['&Function List', 'tab help function-list', '函数列表'],
    \ ['T&ips', 'tab help tips', 'Vim 的各种窍门'],
    \ ['--',''],
    \ ["&Pattern", 'tab help pattern.txt', '正则表达式'],
    \ ["&Registers", 'tab help registers', '寄存器'],
    \ ['&Vim Script', 'tab help eval', 'Vim Script'],
    \ ['--',''],
    \ ["&About", 'version', 'VIM 版本'],
    \ ], 10000)

" Menu Setting -----------------------------------------------------------{{{1
let g:quickui_show_tip = 1
let g:quickui_border_style = 2
" availabe color scheme：borland、gruvbox、solarized、papercol dark、papercol light
let g:quickui_color_scheme = 'borland'

" open menu
" The default menus is located in the system namespace.
noremap <Leader><Leader>m :call quickui#menu#open()<cr>