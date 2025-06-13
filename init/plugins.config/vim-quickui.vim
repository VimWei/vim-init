" https://www.github.com/skywind3000/vim-quickui
" manual: https://github.com/skywind3000/vim-quickui/blob/master/MANUAL.md
" multiple menu namespaces: https://github.com/skywind3000/vim-quickui/wiki/Menu-Namespaces

" clear all the menus ----------------------------------------------------{{{1
call quickui#menu#reset()

" File -------------------------------------------------------------------{{{1
call quickui#menu#install('&File', [
    \ [ "&New File", 'tabnew', '新建文档'],
    \ [ "&Open File ...", 'bro edit', '打开...'],
    \ ["-"],
    \ [ "&Save", 'w', '保存'],
    \ [ "Save All", 'wa', '保存所有文件'],
    \ [ "Save As ...", 'bro w', '另存为...'],
    \ ["-"],
    \ ['Pandoc To &PDF', 'PandocToPDF', '将 markdwon 转为 PDF'],
    \ ['Pandoc To &DOCX', 'PandocToDOCX', '将 markdwon 转为 DOCX'],
    \ ['Pandoc To &HTML', 'PandocToHTML', '将 markdwon 转为 HTML'],
    \ ["-"],
    \ [ "&Close Window", 'close', '关闭当前窗口'],
    \ [ "Close &Tab", ':tabclose', '关闭当前标签页'],
    \ ["-"],
    \ [ "&Quit", 'quit', '退出当前窗口'],
    \ [ "Save &All and Quit", 'wqa', '保存并退出'],
    \ [ "Quit &Without Saving", 'quit!', '不保存退出'],
    \ ])

" Edit -------------------------------------------------------------------{{{1
call quickui#menu#install("&Edit", [
    \ ['Set Filetype &Markdown', 'set ft=markdown', '将文件类型设置为 Markdown'],
    \ ['Markdown TOC', 'TOC', '列出 Markdown 目录 TOC'],
    \ ["-"],
    \ ['&OCRClean', 'OCRClean', '清理 OCR 文档的格式'],
    \ ['gq&Format', 'normal! ggVGgq', '全文 gq 格式化'],
    \ ['&Un gqFormat', 'UngqFormat', '恢复 gq 格式化'],
    \ ["-"],
    \ ['&Explode to Paragraph', 'call Markdown#Explode2P()', '将行转为段落 explode'],
    \ ['Full To Half &Digit', 'FullToHalfDigit', '全角数字转半角'],
    \ ['Tab to Space', 'call ReTab#Tab2Space()', 'Tab to Space'],
    \ ['Space to Tab', 'call ReTab#Space2Tab()', 'Space to Tab'],
    \ ["-"],
    \ ['Wrap In Code Block', 'call Markdown#WrapInCodeBlock()', '添加代码块标记'],
    \ ["-"],
    \ ['&Translate Word', 'call Translator#Words("n")', '翻译当前词汇'],
    \ ])

" Wiki -------------------------------------------------------------------{{{1
call quickui#menu#install("&Wiki", [
    \ ['&Wiki Index', 'WikiIndex', '打开 Wiki Index'],
    \ ['Wiki Index in Tab', 'call Wikivim#OpenWikiIndexTab()', '打开 Wiki Index in Tab'],
    \ ['Open RoadShow', 'call Wikivim#OpenWikiPage("Research/路演.md")', '打开 RoadShow'],
    \ ['&Delete wiki page', 'WikiPageDelete', '删除 wiki page'],
    \ ['&Rename wiki page', 'WikiPageRename', '重命名 wiki page'],
    \ ["-"],
    \ ['Journal &Index', 'call Wikivim#OpenWikiPage("journal.md")', '打开 Journal Index'],
    \ ['&Update Journal Index', 'call Wikivim#UpdateJournalIndex()', '更新 Journal Index'],
    \ ['Open &today journal', 'WikiJournal', '打开 today journal'],
    \ ['Open &next journal', 'WikiJournalNext', '打开 next journal'],
    \ ['Open &previous journal', 'WikiJournalPrev', '打开 previous journal'],
    \ ["-"],
    \ ['&View markdown image', 'call Markdown#ViewImage()', '打开markdown图片'],
    \ ['Paste image to markdown', 'call mdip#MarkdownClipboardImage()', '粘贴图片到markdown'],
    \ ["-"],
    \ ['WikiTagReload', 'WikiTagReload', 'Source wiki files and reload tags'],
    \ ['ListWikiTag', 'WikiTagList -output cursor', 'List all tags and the wiki pages'],
    \ ['WikiTag&Search', 'WikiTagSearch', 'List wiki pages that contain the desired tag'],
    \ ['WikiTags', 'WikiTags', 'search for and navigate to a tag'],
    \ ])

" Bullet -----------------------------------------------------------------{{{1
call quickui#menu#install("&Bullet", [
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
    \ ["-"],
    \ ['Toggle todo checkbox', 'ToggleTodoCheckbox', '切换 todo checkbox'],
    \ ])

    " \ ['Toggle Todo status done [ ] [X] ', 'VimwikiToggleListItem', '切换 Todo 完成状态'],
    " \ ['Toggle Todo status Reject [ ] [-]', 'VimwikiToggleRejectedListItem', '切换 Todo 启用状态'],
    " \ ['Increase done status [ ] [.] [o]', 'normal gln', '增加 Done 的成熟度'],
    " \ ['Decrease done status [o] [.] [ ]', 'normal glp', '降低 Done 的成熟度'],
    " \ ['Remove checkbox [ ] from list item', 'VimwikiRemoveSingleCB', '移除 Todo checkbox'],

" Tools ------------------------------------------------------------------{{{1
call quickui#menu#install("&Tools", [
    \ ["&Update plugins", "PlugUpdate", 'Update plugins'],
    \ ["Upgrade vim-plug", "PlugUpgrade", 'Upgrade vim-plug'],
    \ ["Plugin &Status", "PlugStatus", 'List available plugins'],
    \ ["-"],
    \ ["Update &VIMRC", "call Vimrc#Update()", 'Update VIMRC'],
    \ ["&Edit VIMRC", 'VI', '在新窗口编辑VIMRC'],
    \ ["Edit &Menu", 'VM', '在新窗口编辑菜单'],
    \ ["Edit &Navigator", 'VN', '在新窗口编辑导航'],
    \ ["-"],
    \ ['Random ColorScheme &Favorite', 'call Color#RandomFavoriteScheme()', '随机采用最喜欢的colorscheme'],
    \ ['Random ColorScheme &All', 'call Color#RandomColorScheme()', '随机采用所有的colorscheme'],
    \ ])

" Option -----------------------------------------------------------------{{{1
" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("&Option", [
    \ ['Set &Spell %{&spell? "Off":"On"}', 'call Spell#Toggle()', '拼写检查 Toggle'],
    \ ['Set &Number Toggle', 'set number!', '行号 Toggle'],
    \ ['Set &Relativenumber Toggle', 'set relativenumber!', '相对行号 Toggle'],
    \ ['Set Wrap Toggle', 'set wrap!', '自动换行 Toggle'],
    \ ["-"],
    \ ['Cursor &Line Toggle', 'set cursorline!', '光标行加亮 Toggle'],
    \ ['&Fold Column Toggle', 'FoldColumnToggle', '折叠栏 Toggle'],
    \ ['&Multi Column Toggle', 'MultiColumnToggle', '多栏模式 Toggle'],
    \ ["-"],
    \ ["ColorColumn &CursorPos", 'CColumn', '设置 cursor pos 为对齐线'],
    \ ["ColorColumn &Textwidth", 'CColumnTextwidth', '设置 Textwidth 为对齐线'],
    \ ["ColorColumn Remove&All", 'CColumnRemoveAll', '取消所有的对齐线'],
    \ ["-"],
    \ ['&Whitespace Stripping Toggle', 'ToggleStrip', '清除多余的空白 Toggle'],
    \ ['vim-auto-&popmenu Toggle', 'ToggleApc', 'vim-auto-popmenu Toggle'],
    \ ["-"],
    \ ["Options Help", 'tab help options', '关于 options 的帮助文档'],
    \ ])

" Help -------------------------------------------------------------------{{{1
call quickui#menu#install('Hel&p', [
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
