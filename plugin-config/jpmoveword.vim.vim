" https://www.github.com/fuenor/jpmoveword.vim

" jpmoveword.vim ---------------------------------------------------------{{{1
" 这是 W、E 和 B 的替代命令，可识别并移动任意分隔符
" 并添加了 iW/aW 文本对象，及 il/al 文本对象
let jpmoveword_enable_WBE = 1
let jpmoveword_separator = '、，；：。！？'
let jpmoveword_stop_separator = 0

" 若不设置virtualedit，以下 xxx_stop_eol 设置 1 和 2 没有区别
" set virtualedit+=onemore
let jpmoveword_stop_eol = 0
" let jpmoveword_stop_eol = 0 : 越过行尾时不执行任何操作
" let jpmoveword_stop_eol = 1 : 越过行尾时在 eol 处停止
" let jpmoveword_stop_eol = 2 : 越过行尾时在行尾字符处停止

" eolmoveword.vim --------------------------------------------------------{{{1
" 默认 的 w、e、b 移动命令不会在 EOL（行尾）处停止，即使它们越过了行尾。
" 在英语中，它很方便，因为它是逐字的，但在日语中，停在行尾可能很有用。
" 中文环境中，好像不太需要
let moveword_enable_wbe = 0
" let moveword_stop_eol = 0 : 越过行尾时不执行任何操作
" let moveword_stop_eol = 1 : 越过行尾时在 eol 处停止
" let moveword_stop_eol = 2 : 越过行尾时在行尾字符处停止

" mpsobject.vim ----------------------------------------------------------{{{1
" 使用“%”命令轻松移动对称项目，并添加了“i%”和“a%”文本对象
" vim自带了 matchit 插件，足够使用了
let matchpairs_textobject = 0
