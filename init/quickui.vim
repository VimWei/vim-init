"===================================================
" quickui settings by W.Chen
" Sourced by: ../init.vim
"===================================================

if has('patch-8.2.1') == 0 || has('nvim')
    finish
endif

" Navigator ---------------------------------------------------------------{{{1
" ref: https://github.com/skywind3000/vim-navigator?tab=readme-ov-file#configuration

" initialize global keymap and declare prefix key
let g:navigator = {'prefix':'\'}
let g:navigator_v = {'prefix':'\'}

" help  -------------------------------------------------------------------{{{2
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
    \ 'c' : ['set hlg=cn', '帮助语言：中文'],
    \ 'e' : ['set hlg=en', '帮助语言：English'],
    \ }

" Vimrc -------------------------------------------------------------------{{{2
let g:navigator.v = {
    \ 'name': '+VIMRC',
    \ 'v' : [':edit $MYVIMRC', 'VIMRC'],
    \ 'i' : ['EditInitVimrc("init.vim")', 'init.vim'],
    \ 'e' : ['EditInitVimrc("essential.vim")', 'essential.vim'],
    \ 't' : ['EditInitVimrc("tabsize.vim")', 'tabsize.vim'],
    \ 'l' : ['EditInitVimrc("statusline.vim")', 'statusline.vim'],
    \ 's' : ['EditInitVimrc("search.vim")', 'search.vim'],
    \ 'g' : ['EditInitVimrc("guistyle.vim")', 'guistyle.vim'],
    \ 'k' : ['EditInitVimrc("keymaps.vim")', 'keymaps.vim'],
    \ 'p' : ['EditInitVimrc("plugins.vim")', 'plugins.vim'],
    \ 'q' : ['EditInitVimrc("quickui.vim")', 'quickui.vim'],
    \ 'a' : ['EditInitVimrc("autoload.vim")', 'autoload.vim'],
    \ 'c' : ['EditInitVimrc("colorscheme.vim")', 'colorscheme.vim'],
    \ }

" buffer ------------------------------------------------------------------{{{2
let g:navigator.b = {
    \ 'name' : '+Buffer',
    \ 'l' : [':ls', '查看缓存列表'],
    \ 'd' : [':bd', 'delete-buffer'],
    \ '0' : [':bfirst', 'first-buffer'],
    \ 'n' : [':bnext', 'next-buffer'],
    \ 'p' : [':bprevious', 'previous-buffer'],
    \ '$' : [':blast', 'last-buffer'],
    \ '?' : [':Leaderf buffer', 'Leaderf b'],
    \ }

" tab ---------------------------------------------------------------------{{{2
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

" Fold --------------------------------------------------------------------{{{2
let g:navigator.f = {
    \ 'name': '+Fold',
    \ 'a' : ['<key>za', 'za，<M-space> 切换折叠状态'],
    \ 'A' : ['<key>zA', 'zA，以循环方式切换折叠状态'],
    \ 'm' : ['<key>zm', 'zm，关闭所有折叠'],
    \ 'i' : ['<key>zi', 'zi，展开所有折叠'],
    \ 'v' : ['<key>zMzv', 'zMzv，<S-space> 打开当前折叠并关闭其他'],
    \ 'T' : ['FoldColumnToggle()', 'Toggle FoldColumn'],
    \ }

" Options ---------------------------------------------------------------------{{{2
let g:navigator.o = {
    \ 'name': '+Options',
    \ 'a' : [':set all', '简易显示所有选项的设置'],
    \ 'o' : [':tab options', '阅读和设置所有选项'],
    \ 'h' : [':tab help options.txt', 'Options 帮助文档'],
    \ 'c' : {
        \ 'name' : '+Cursorline',
        \ 'o' : [':set cursorline', '打开高亮显示 cursorline'],
        \ 'f' : [':set nocursorline', '关闭高亮显示 cursorline'],
        \ },
    \ 'n' : {
        \ 'name' : '+Number',
        \ 'n' : [':set number', '显示行号'],
        \ 'N' : [':set nonumber', '不显示行号'],
        \ 'r' : [':set relativenumber', '显示相对行号'],
        \ 'R' : [':set norelativenumber', '不显示相对行号'],
        \ },
    \ 'w' : {
        \ 'name' : '+Wrap',
        \ 'w' : [':set wrap', '自动换行'],
        \ 'W' : [':set nowrap', '关闭自动换行'],
        \ },
    \ 's' : {
        \ 'name' : '+Spell',
        \ 's' : [':call Spell#Toggle()', 'Toggle spell check'],
        \ 'n' : ['<key>]s', ']s Next spell'],
        \ 'p' : ['<key>[s', '[s Previous spell'],
        \ '=' : ['<key>z=', 'z= 选择用户拼写'],
        \ 'g' : ['<key>zg', 'zg 将好词 (good) 加入到 spellfile'],
        \ 'u' : ['<key>zug', 'zug 撤销zg，从 spellfile 里删除单词'],
        \ 'w' : ['<key>zw', 'zw 将错词 (wrong) 加入到 spellfile'],
        \ 'v' : ['<key>zuw', 'zuw 撤销zw，从 spellfile 里删除单词'],
        \ },
    \ }

" Markdown ----------------------------------------------------------------{{{2
let g:navigator.m = {
    \ 'name' : '+Markdown',
    \ 'f' : [':set ft=markdown', '将文件类型设置为markdown'],
    \ 't' : [':TOC', '列出目录 TOC'],
    \ 'c' : [':OCRClean', '清理 OCR 文档的格式'],
    \ 'd' : [':FullToHalfDigit', '全角数字转半角'],
    \ 'q' : ['<key>ggVGgq', '全文 gq 格式化'],
    \ 'u' : [':UngqFormat', '恢复 gq 格式化'],
    \ 'e' : ['Explode2P()', '将全文的行转为段落 explode'],
    \ }

let g:navigator_v.m = {
    \ 'name' : '+Markdown',
    \ 'q' : ['<key>gq', '选区 gq 格式化'],
    \ 'u' : [":UngqFormat", '恢复 gq 格式化'],
    \ 'e' : ['Explode2P()', '将选区的行转为段落 explode'],
    \ }

" Wiki.vim ----------------------------------------------------------------{{{2
let g:navigator.w = {
    \ 'name' : '+Wiki.vim',
    \ 'w' : [':WikiIndex', 'Open Wiki index'],
    \ 't' : [':tabnew | WikiIndex', 'Open Wiki index in a new tab'],
    \ 's' : [':call WikiFile("Research/路演.md")', 'Open RoadShow index'],
    \ 'd' : ['<plug>(wiki-page-delete)', 'Delete wiki page'],
    \ 'r' : ['<plug>(wiki-page-rename)', 'Rename wiki page'],
    \ 'j' : {
        \ 'name' : '+Journal',
        \ '0' : [':call WikiFile("journal/Journal.md")', 'Open diary index file'],
        \ '1' : [':WikiJournal', 'Open today diary'],
        \ '5' : ['<plug>(wiki-journal-next)', 'Open next day diary'],
        \ '6' : ['<plug>(wiki-journal-prev)', 'Open previous day diary'],
        \ 'u' : [':WikiJournalIndex', 'Update Journal index'],
        \ 't' : ['<key>a<C-R>=strftime("%Y-%m-%d %A %H:%M:%S")<CR><Esc>', 'Insert datetime'],
        \ },
    \ 'L' : {
        \ 'name' : '+List',
        \ '1' : [':VimwikiChangeSymbolTo *', '更改当前列表符号为 *'],
        \ '2' : [':VimwikiChangeSymbolTo -', '更改当前列表符号为 -'],
        \ '3' : [':VimwikiChangeSymbolTo 1.', '更改当前列表符号为 1'],
        \ '4' : [':VimwikiRenumberList', '重建当前列表编号'],
        \ '5' : [':VimwikiRenumberAllLists', '重建全文列表编号'],
        \ '6' : [':normal gll', '升高当前列表级别-->'],
        \ '7' : [':normal glh', '降低当前列表级别<--'],
        \ },
    \ 'T' : {
        \ 'name' : '+Todo' ,
        \ '1' : [':VimwikiToggleListItem', '切换 Todo 完成状态 [ ] [X]'],
        \ '2' : [':VimwikiToggleRejectedListItem', '切换 Todo 启用状态 [ ] [-]'],
        \ '3' : [':normal gln', '增加 Done 的成熟度 [ ] [.] [o]'],
        \ '4' : [':normal glp', '降低 Done 的成熟度 [o] [.] [ ]'],
        \ '5' : [':VimwikiNextTask', '跳到下一个未完成的任务'],
        \ '6' : [':VimwikiRemoveSingleCB', '移除 Todo checkbox [ ]'],
        \ },
    \ }

" git  --------------------------------------------------------------------{{{2
let g:navigator.g = {
    \ 'name' : '+Git',
    \ 'g' : {
        \ 'name' : '+Git 常规流程 Summary window',
        \ '1' : [':Git pull', ':git pull'],
        \ '2' : [':Git', ':git status --> Summary window'],
        \ '3' : ['<key>s', ':git add . --> s'],
        \ '4' : ['<key>cc', ':git commit -m --> cc'],
        \ '5' : [':Git push', ':git push'],
        \ },
    \ 'd' : {
        \ 'name' : '+Diff',
        \ 'd' : [':Git diff', '显示工作目录和暂存区之间的差异 :git diff'],
        \ 'e' : [':Git! difftool -y', 'git diff each changed file in a new tab'],
        \ 'f' : [':Git diff --staged', '显示暂存区和上一次提交之间的差异 :git diff --staged'],
        \ 'm' : [':Gdiffsplit!', '在处理冲突合并时进行三向对比 :Gdiffsplit!'],
        \ },
    \ 'o' : {
        \ 'name' : '+Log',
        \ 'b' : [':Git blame %', '在行级显示文件的修改历史 :git blame %'],
        \ 'o' : [':Git log --oneline', '显示提交历史记录，每个一行'],
        \ 'q' : [':Gclog', '显示提交历史记录，加载到 quickfix'],
        \ },
    \ 'c' : [':Gcd', '切换目录到relative to the repository :Gcd'],
    \ }

" Python ------------------------------------------------------------------{{{2
let g:navigator.p = {
    \ 'name' : '+Python',
    \ 't' : [':TerminalConda', 'Open Terminal in conda pymotw'],
    \ 'p' : [':Python', 'Open Python in conda pymotw'],
    \ 'i' : [':IPython', 'Open IPython in conda pymotw'],
    \ 'r' : [':PyRun', 'Run python file in conda pymotw'],
    \ }

" let g:navigator_python = {
"     \ 'prefix' : '\',
"     \ 'p' : {
"         \ 'name' : '+Python',
"         \ 't' : [':TerminalConda', 'Open Terminal in conda pymotw'],
"         \ 'p' : [':Python', 'Open Python in conda pymotw'],
"         \ 'i' : [':IPython', 'Open IPython in conda pymotw'],
"         \ 'r' : [':PyRun', 'Run python file in conda pymotw'],
"         \ },
"     \ }
" autocmd FileType python let b:navigator = g:navigator_python

" navigator config --------------------------------------------------------{{{2
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

let g:navigator_v.config = {
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

nnoremap <silent>\ :Navigator *:navigator<cr>
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
    \ [ "Save &all", 'wa', '保存所有文件'],
    \ [ "Save as", 'bro w', '另存为...'],
    \ [ "--", '' ],
    \ [ "&New File", 'tabnew', '新建文档'],
    \ [ "&Open File", 'bro edit', '打开...'],
    \ ])

" items containing tips, tips will display in the cmdline
call quickui#menu#install("&Tools", [
    \ ["&Update plugins", "PlugUpdate", 'update plugins'],
    \ ["Upgrade vim-plug", "PlugUpgrade", 'upgrade vim-plug'],
    \ ["Plugin &List", "PlugStatus", 'list available plugins'],
    \ ["-"],
    \ ["Edit MENU", 'VQ', '在新窗口编辑菜单'],
    \ ["Edit VIMRC", 'VI', '在新窗口编辑VIMRC'],
    \ ])

" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("&Option", [
    \ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!', 'Toggle spell check %{&spell? "off" : "on"}'],
    \ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!', 'Toggle cursor line %{&cursorline? "off" : "on"}'],
    \ ["-"],
    \ ["Options help", 'tab help options', '关于 options 的帮助文档'],
    \ ])

" Markdown
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
    \ ['Increase List Level -->', 'normal gll', '升高当前列表级别 gll'],
    \ ['Decrease List Level <--', 'normal glh', '降低当前列表级别 glh'],
    \ ["-"],
    \ ['Update diary index', 'VimwikiDiaryGenerateLinks', '更新Diary索引目录'],
    \ ["Rebuild Tags", 'VimwikiRebuildTags!', '重新生成Tags'],
    \ ], '<auto>', 'markdown')

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
    \ ["&Pattern", 'tab help pattern.txt', '正则表达式'],
    \ ["&Registers", 'tab help registers', '寄存器'],
    \ ['&Vim Script', 'tab help eval', 'Vim Script'],
    \ ['--',''],
    \ ["&About", 'version', 'VIM 版本'],
    \ ], 10000)

let g:quickui_show_tip = 1
let g:quickui_border_style = 2
" availabe color scheme：borland、gruvbox、solarized、papercol dark、papercol light
let g:quickui_color_scheme = 'gruvbox'

" open menu
" multiple menu namespaces: https://github.com/skywind3000/vim-quickui/wiki/Menu-Namespaces
" The default menus is located in the system namespace.
noremap <Leader><Leader>m :call quickui#menu#open()<cr>
