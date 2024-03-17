"===================================================
" Autoload's map settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Python ------------------------------------------------------------------{{{1
" 详情查阅 ../autoload/CondaPython.vim

" 定义一个公共函数，用于处理可选的 Conda 环境参数
function! CondaEnvCommand(env, command, ...)
    " a:0 指函数被调用时传递的参数的数量
    if a:0 == 0
        if a:command == 'PASS'
            " 不执行命令PASS
            call CondaPython#CondaEnv(a:env)
        else
            call CondaPython#CondaEnv(a:env, a:command)
        endif
    elseif a:0 == 1
        if a:command == 'PASS'
            " 不执行命令PASS
            " a:1、a:2、a:3 等值函数被调用时传递的第1-3个参数
            call CondaPython#CondaEnv(a:1)
        else
            call CondaPython#CondaEnv(a:1, a:command)
        endif
    else
        " 若参数为2个及以上，则将参数全部传入
        let l:args = []
        for i in range(1, a:0)
            call add(l:args, get(a:, i))
        endfor
        " 如果a:1为空，则设置为默认值 a:env
        if a:1 == '""' || a:1 == ''''''
            let l:args[0] = a:env
        endif
        call call('CondaPython#CondaEnv', l:args)
    endif
endfunction

" 以下4个命令，运行格式一样，第1个参数代表conda env，之后的代表cmd命令
" command! YourCommand call CondaPython#CondaEnv("env", "cmd1", "cmd2", ...)
"
"使用:TerminalConda，打开默认的conda环境pymotw
"使用:TerminalConda myEnv，打开指定的conda环境myEnv
"使用:TerminalConda myEnv ipython，打开指定的conda环境myEnv，并执行ipython
command! -nargs=* TerminalConda call CondaEnvCommand('pymotw', 'PASS', <f-args>)

"使用:Python，在默认的conda环境pymotw中，运行python
"使用:Python myEnv，在指定的conda环境myEnv中，运行python
"使用:Python myEnv ipython，在指定的conda环境myEnv中，运行ipython
" 使用:Python "" ipython，在默认的conda环境pymotw中，运行ipython
command! -nargs=* Python call CondaEnvCommand('pymotw', 'python', <f-args>)

"使用:IPython，在默认的conda环境pymotw中，打开IPython
"使用:IPython myEnv，在指定的conda环境myEnv中，打开IPython
"使用:IPython myEnv python，在指定的conda环境myEnv中，打开python
" 使用:IPython "" python，在默认的conda环境pymotw中，运行python
command! -nargs=* IPython call CondaEnvCommand('pymotw', 'ipython', <f-args>)

" 使用:PyRun 或者 F5，在默认的conda环境pymotw中，使用python执行当前buffer
" 使用:PyRun myEnv，在指定的conda环境myEnv中，使用python执行当前buffer
" 使用:PyRun myEnv ipython，在指定的conda环境myEnv中，运行ipython
" 使用:PyRun "" ipython，在默认的conda环境pymotw中，运行ipython
command! -nargs=* PyRun call CondaEnvCommand('pymotw', 'python "' . expand('%:p') . '"', <f-args>)
map <F5> :call CondaEnvCommand('pymotw', 'python "' . expand('%:p') . '"')<CR>

" translator在线翻译 ------------------------------------------------------{{{1
" 详情查阅 ../autoload/Translator.vim
nnoremap <leader>dt :call Translator#PyNormal('tools/dict/', 'translator.py')<CR>
vnoremap <leader>dt y:call Translator#PyVisual('tools/dict/', 'translator.py')<CR>

" PinYin拼音查询 ----------------------------------------------------------{{{1
" 详情查阅 ../autoload/PinYin.vim
" 使用Leaderf查询光标所在位置单字的拼音、双拼、同音字、常用词组
nnoremap <leader>yf :call PinYin#WordStar()<CR>
command! PinYin call PinYin#WordStar()

" 使用pypinyin查询词汇拼音，并显示在Quickfix
command! PinYinWords call PinYin#PyNormal()
nnoremap <leader>yq :call PinYin#PyNormal()<CR>
vnoremap <leader>yq y:call PinYin#PyVisual()<CR>

" 使用pypinyin查询词汇拼音，并显示在词汇所在行的上方
nnoremap <leader>yi :-r!pypinyin <C-r><C-w><CR>
vnoremap <leader>yi y:-r!pypinyin <C-r>0<CR>

" 查询输入的汉语单字或拼音 - 拼音索引
command! -nargs=1 PinyinIndex call PinYin#Index(<f-args>)<CR>
" 查询输入的汉语单字或拼音 - 易混拼音
command! -nargs=1 PinyinConfusion call PinYin#Confusion(<f-args>)<CR>

" OpenCC繁简转换 ----------------------------------------------------------{{{1
" 详情查阅 ../autoload/OpenCC.vim
" 繁体（台湾正体标准）到简体并转换为中国大陆常用词汇
command! -range OpenCCTW2SP <line1>,<line2>call OpenCC#OpenCC("tw2sp.json")
" 简体到繁体（台湾正体标准）并转换为台湾常用词汇
command! -range OpenCCS2TWP <line1>,<line2>call OpenCC#OpenCC("s2twp.json")

" ColorColumn -------------------------------------------------------------{{{1
" 详情查阅 ../autoload/ColorColumn.vim
" 切换显示当前所在位置的对齐线
" 命令行自定义使用 :set cc=  "若值留空，则取消对齐线
command! CColumn call ColorColumn#ColorColumnSet()
command! CColumnTextwidth call ColorColumn#ColorColumnTextwidth()
command! CColumnRemoveAll call ColorColumn#ColorColumnRemoveAll()

" MultiColumn -------------------------------------------------------------{{{1
" 详情查阅 ../autoload/MultiColumn.vim
command! MColumn call MultiColumn#Add()
command! MColumnRemove call MultiColumn#Remove()

" Pandoc ------------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Pandoc.vim
command! PandocToPDF call Pandoc#ToPdf()
command! PandocToDOCX call Pandoc#ToDocx()
command! PandocToHTML call Pandoc#ToHtml()

" HtmlTidy ----------------------------------------------------------------{{{1
" 详情查阅 ../autoload/HtmlTidy.vim
" 使用如下命令实施Tidy美化，并输出文件到CWD中
" nnoremap <leader>ht :call HtmlTidy#Tidy()<CR>
command! HtmlTidy call HtmlTidy#Tidy()
" 采用VimScript简化版
" nnoremap <leader>hp :call HtmlTidy#Prettify()<CR>
command! HtmlPrettify call HtmlTidy#Prettify()

" Mdict -------------------------------------------------------------------{{{1
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

" AutoStrip TrailingWhitespace --------------------------------------------{{{1
" 详情查阅 ../autoload/Strip.vim
autocmd BufWritePre * call Strip#TrailingWhitespace()

" Spell -------------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Spell.vim
" inoremap <Leader>s <C-o>:call Spell#Toggle()<CR>
nnoremap <Leader>s :call Spell#Toggle()<CR>

" Markdown ----------------------------------------------------------------{{{1

" TOC ---------------------------------------------------------------------{{{2
" 详情查阅 ../autoload/TOC.vim
nnoremap <leader><Leader>t :TOC<CR>
let g:TOC#position = "left"
let g:TOC#autofit = 1
let g:TOC#close_after_navigating = 0
autocmd FileType markdown call TOC#Init()

" UngqFormat --------------------------------------------------------------{{{2
" 详情查阅 ../autoload/Markdown.vim

" 恢复被 gq 格式化的文档格式
" :UngqFormat：处理整个文件。
" :'<,'>UngqFormat：处理当前选区。
command! -range=% UngqFormat call Markdown#UngqFormat(<line1>, <line2>)

" 全角数字转半角 ----------------------------------------------------------{{{2
" 详情查阅 ../autoload/Markdown.vim

command! FullToHalfDigit call Markdown#FullToHalfDigit()

" OCRClean ----------------------------------------------------------------{{{2
" 详情查阅 ../autoload/OCRmyPDF.vim
command! OCRClean call OCRmyPDF#Clean()

" Redir -------------------------------------------------------------------{{{1
" 详情查阅 ../autoload/Redir.vim
command! -nargs=1 -complete=command Redir silent call Redir#redir(<q-args>)

" Finish ------------------------------------------------------------------{{{1

finish

" 查阅python帮助文档
" command! PyHelp call CondaPython#PyHelpTerminal()
" nnoremap <leader>ph :exec "call CondaPython#PyHelpTerminal()" <CR>
command! PyHelp call CondaPython#PyHelpTerminal()
command! -nargs=1 PyRun call CondaPython#CondaEnv(<f-args>, 'python "$(VIM_FILEPATH)"')
