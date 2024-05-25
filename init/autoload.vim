"===================================================
" Autoload's map settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Python -----------------------------------------------------------------{{{1
" 详情查阅 ../autoload/CondaPython.vim

" 以下4个命令，运行格式一样，第1个参数代表conda env，之后的代表cmd命令
" command! YourCommand call CondaPython#CondaEnv("env", "mode"，"cmd1", "cmd2", ...)

" 使用:TerminalConda，打开默认的conda环境pymotw
" 使用:TerminalConda myEnv，打开指定的conda环境myEnv
" 使用:TerminalConda myEnv "" ipython，打开指定的conda环境myEnv，并执行ipython
" 使用:TerminalConda "" "" ipython，在默认的conda环境pymotw中，运行ipython
command! -nargs=* TerminalConda call CondaPython#CondaEnvCommand('pymotw', 'terminal', 'PASS', <f-args>)

" 使用:Python，在默认的conda环境pymotw中，运行python
" 使用:Python myEnv，在指定的conda环境myEnv中，运行python
" 使用:Python myEnv "" ipython，在指定的conda环境myEnv中，运行ipython
" 使用:Python "" "" ipython，在默认的conda环境pymotw中，运行ipython
command! -nargs=* Python call CondaPython#CondaEnvCommand('pymotw', 'terminal', 'python', <f-args>)
command! -nargs=* Lua call CondaPython#CondaEnvCommand('pymotw', 'terminal', 'Lua', <f-args>)

" 使用:IPython，在默认的conda环境pymotw中，打开IPython
" 使用:IPython myEnv，在指定的conda环境myEnv中，打开IPython
" 使用:IPython myEnv "" python，在指定的conda环境myEnv中，打开python
" 使用:IPython "" "" python，在默认的conda环境pymotw中，运行python
command! -nargs=* IPython call CondaPython#CondaEnvCommand('pymotw', 'terminal', 'ipython', <f-args>)

" 使用:PyRun 或者 F5，在默认的conda环境pymotw中，使用python执行当前buffer
" 使用:PyRun myEnv，在指定的conda环境myEnv中，使用python执行当前buffer
" 使用:PyRun myEnv "" ipython，在指定的conda环境myEnv中，运行ipython
" 使用:PyRun "" "" ipython，在默认的conda环境pymotw中，运行ipython
command! -nargs=* PyRun call CondaPython#CondaEnvCommand('pymotw', 'terminal', 'python "' . expand('%:p') . '"', <f-args>)
map <F5> :call CondaPython#CondaEnvCommand('pymotw', 'terminal', 'python "' . expand('%:p') . '"')<CR>

" 查阅python帮助文档
nnoremap <leader>ph :call CondaPython#Help()<CR>

" Pandoc -----------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Pandoc.vim
command! PandocToPDF call Pandoc#ToPdf()
command! PandocToDOCX call Pandoc#ToDocx()
command! PandocToHTML call Pandoc#ToHtml()

" Redir ------------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Redir.vim
command! -nargs=1 -complete=command Redir silent call Redir#redir(<q-args>)

" ColorColumn ------------------------------------------------------------{{{1
" 详情查阅 ../autoload/ColorColumn.vim
" 切换显示当前所在位置的对齐线
" 命令行自定义使用 :set cc=  "若值留空，则取消对齐线
command! CColumn call ColorColumn#ColorColumnSet()
command! CColumnTextwidth call ColorColumn#ColorColumnTextwidth()
command! CColumnRemoveAll call ColorColumn#ColorColumnRemoveAll()

" MultiColumn ------------------------------------------------------------{{{1
" 详情查阅 ../autoload/MultiColumn.vim
command! MColumn call MultiColumn#Add()
command! MColumnRemove call MultiColumn#Remove()

" Fold -------------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Fold.vim
nnoremap <Leader>am :call Fold#AddMarker()<CR>

" 切换是否显示foldcolumn
command! FoldColumnToggle call Fold#ColumnToggle()
nnoremap zf :call Fold#ColumnToggle()<CR>

" Spell ------------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Spell.vim
" inoremap <Leader>s <C-o>:call Spell#Toggle()<CR>
nnoremap <Leader>s :call Spell#Toggle()<CR>

" AutoStrip --------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Strip.vim
autocmd BufWritePre * call Strip#TrailingWhitespace()

" OCRClean ---------------------------------------------------------------{{{1
" 详情查阅 ../autoload/OCRmyPDF.vim
command! OCRClean call OCRmyPDF#Clean()

" HtmlTidy ---------------------------------------------------------------{{{1
" 详情查阅 ../autoload/HtmlTidy.vim
" 使用如下命令实施Tidy美化，并输出文件到CWD中
" nnoremap <leader>ht :call HtmlTidy#Tidy()<CR>
command! HtmlTidy call HtmlTidy#Tidy()
" 采用VimScript简化版
" nnoremap <leader>hp :call HtmlTidy#Prettify()<CR>
command! HtmlPrettify call HtmlTidy#Prettify()

" TOC --------------------------------------------------------------------{{{1
" 详情查阅 ../autoload/TOC.vim
nnoremap <leader><Leader>t :TOC<CR>
let g:TOC#position = "left"
let g:TOC#autofit = 1
let g:TOC#close_after_navigating = 0
autocmd FileType markdown call TOC#Init()

" Explode2P --------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Markdown.vim
nnoremap <leader>me :call Markdown#Explode2P()<CR>
vnoremap <leader>me :call Markdown#Explode2P()<CR>

" UngqFormat -------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Markdown.vim

" 恢复被 gq 格式化的文档格式
" :UngqFormat：处理整个文件。
" :'<,'>UngqFormat：处理当前选区。
command! -range=% UngqFormat call Markdown#UngqFormat(<line1>, <line2>)

" 全角数字转半角 ---------------------------------------------------------{{{1
" 详情查阅 ../autoload/Markdown.vim

command! FullToHalfDigit call Markdown#FullToHalfDigit()

" OpenCC繁简转换 ---------------------------------------------------------{{{1
" 详情查阅 ../autoload/OpenCC.vim

let opencc_configs = [ ]
" 简繁（OpenCC 标准）单字转换
" let opencc_configs += [ 's2t.json', 't2s.json' ]
" 简繁（台湾正体标准）单字转换
let opencc_configs += [ 's2tw.json', 'tw2s.json' ]
" 简繁（台湾正体标准）单字及常用词汇转换
let opencc_configs += [ 's2twp.json', 'tw2sp.json' ]
" 简繁（香港小学学习字词表标准）单字转换
" let opencc_configs += [ 's2hk.json', 'hk2s.json' ]
" 繁体（OpenCC 标准）到繁体（台湾正体标准）
" let opencc_configs += [ 't2tw.json' ]
" 繁体（OpenCC 标准）到繁体（香港小学学习字词表标准）
" let opencc_configs += [ 't2hk.json' ]

for config in opencc_configs
    let command_name = 'Opencc' . toupper(substitute(config, '\.json$', '', ''))
    execute 'command! -range ' . command_name . ' <line1>,<line2>call OpenCC#OpenCC("' . config . '")'
endfor

" translator在线翻译 -----------------------------------------------------{{{1
" 详情查阅 ../autoload/Translator.vim
nnoremap <leader>dt :call Translator#Words('n')<CR>
vnoremap <leader>dt :call Translator#Words('v')<CR>

" PinYin拼音查询 ---------------------------------------------------------{{{1
" 详情查阅 ../autoload/PinYin.vim
" 使用Leaderf查询光标所在位置单字的拼音、双拼、同音字、常用词组
nnoremap <leader>ps :call PinYin#SingleWord()<CR>
command! PinYinSingleWord call PinYin#SingleWord()

" 使用pypinyin查询词汇拼音，并显示在Quickfix
command! PinYinWords call PinYin#Words('n')
nnoremap <leader>pw :call PinYin#Words('n')<CR>
vnoremap <leader>pw :call PinYin#Words('v')<CR>

" 使用pypinyin查询词汇拼音，并显示在词汇所在行的上方
nnoremap <leader>pi :call PinYin#Insert('n')<CR>
vnoremap <leader>pi :call PinYin#Insert('v')<CR>

" 查询输入的汉语单字或拼音 - 拼音索引
command! -nargs=1 PinyinIndex call PinYin#Index(<f-args>)<CR>
" 查询输入的汉语单字或拼音 - 易混拼音
command! -nargs=1 PinyinConfusion call PinYin#Confusion(<f-args>)<CR>

" Mdict ------------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Mdict.vim
" 生成图片词典页码，参数为页码数
command! -nargs=1 MdictCreatPageNum call Mdict#CreatPageNum(<f-args>)
" 将图片词典页码转化为mdx源文件，参数为词典名
command! -nargs=+ MdictPageNumToMdict call Mdict#PageNumToMdict(<f-args>)
" 将词条转化为mdx源文件，参数为词典名
command! -nargs=1 MdictItemToMDX call Mdict#ItemToMdx(<f-args>)
" 将所有行移动到页面中间位置
command! MdictMiddlePage call Mdict#MiddlePage()
" 切换至下一栏
command! MdictTogglePage call Mdict#TogglePage()
