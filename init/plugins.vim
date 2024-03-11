"===================================================
" Package & Plug settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Begin -------------------------------------------------------------------{{{1

"激活matchit，增强%在配对关键字间跳转
packadd! matchit

" Plug自身是一个自动延时加载函数，可放在任意&rtp/autoload目录中即可生效
" 在 Win10 下，其所管理的插件安装目录默认为 ~/vimfiles/plugged/
call plug#begin()

" Basic -------------------------------------------------------------------{{{1

    " Startuptime ---------------------------------------------------------{{{2
    Plug 'dstein64/vim-startuptime'

    " ColorScheme ---------------------------------------------------------{{{2
    Plug 'morhetz/gruvbox'
    Plug 'itchyny/landscape.vim'
    Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' }

    " vimcdoc -------------------------------------------------------------{{{2
    Plug 'yianwillis/vimcdoc'

    " Netrw ---------------------------------------------------------------{{{2
    " 不显示横幅，可以用I轮换
    let g:netrw_banner = 0
    " 瘦列表 (每个文件一行)，可以用i轮换
    let g:netrw_liststyle = 0
    " 排序时忽略大小写，可以用s轮换排序依据
    let g:netrw_sort_options="i"
    " 在当前窗口打开当前缓冲区所在目录，但在vimwiki中被覆盖为其他功能
    map - :<C-u>e %:p:h<CR>
    " 在左侧显示当前缓冲区所在目录
    map <C-n> :Lexplore %:p:h<CR>
    " 指定新建的 :Lexplore 窗口宽度，单位是屏幕的百分比
    let g:netrw_winsize =20

    " Open browser --------------------------------------------------------{{{2
    " gx使用系统默认工具打开光标下的文件、URL等
    Plug 'tyru/open-browser.vim'
    let g:netrw_nogx = 1 " disable netrw's gx mapping.
    nmap gx <Plug>(openbrowser-smart-search)
    vmap gx <Plug>(openbrowser-smart-search)

    " AsyncRun-------------------------------------------------------------{{{2
    Plug 'skywind3000/asyncrun.vim'
    " set shell encoding if it's different from &encoding
    let g:asyncrun_encs = 'gbk'
    " open quickfix window at given height after command starts
    let g:asyncrun_open = 8
    " trim the empty lines in the quickfix window
    let g:asyncrun_trim = 0
    " Display Progress in Status Line
    let g:asyncrun_status = "stopped"
    " let g:asynctasks_term_focus = 1
    augroup QuickfixStatus
        au! BufWinEnter quickfix setlocal
            \ statusline=%t\ [%{g:asyncrun_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P
    augroup END

" Search ------------------------------------------------------------------{{{1

    " EasyMotion ----------------------------------------------------------{{{2
    " 全文快速移动，使用<leader><leader>w/b/s/j/k/l，或者f触发
    Plug 'easymotion/vim-easymotion'

    let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_enter_jump_first = 1
    let g:EasyMotion_use_migemo  = 0

    nmap <leader><leader>l <Plug>(easymotion-bd-jk)
    nmap f <Plug>(easymotion-sn)

    " 拼音首字母查询 ------------------------------------------------------{{{2
    Plug 'ppwwyyxx/vim-PinyinSearch'

    let g:PinyinSearch_Dict = $HOME . '/vimfiles/plugged/vim-PinyinSearch/PinyinSearch.dict'
    nnoremap F :call PinyinSearch()<CR>
    nnoremap <Leader><leader>f :call PinyinNext()<CR>

    " LeaderF -------------------------------------------------------------{{{2
    Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
    let g:Lf_StlColorscheme = 'gruvbox_material'
    let g:Lf_HideHelp = 1
    let g:Lf_WindowHeight = 0.30
    let g:Lf_ShowDevIcons = 0
    let g:Lf_PreviewInPopup = 1
    "F - if the current working directory is not the direct ancestor of current
    "    file, use the directory of the current file as LeaderF's working
    "    directory, otherwise, use the current working directory.
    let g:Lf_WorkingDirectoryMode = 'F'
    let g:Lf_WildIgnore = {
        \ 'dir': ['.svn','.git','.hg'],
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.zip']
        \}
    let g:Lf_ShortcutF = '<leader>f'
    let g:Lf_ShortcutB = '<leader>fb'
    noremap <leader>fm :<C-U>Leaderf mru<CR>
    noremap <leader>fl :Leaderf line --regexMode<CR>
    noremap <leader>fc :Leaderf line --regexMode --input \(\s\+\)\@<!\_^#\+\s\+.*<CR>
    noremap <leader>ft :<C-U>Leaderf tag --regexMode<CR>
    noremap <leader>fh :<C-U>Leaderf help<CR>
    noremap <leader>fg :<C-U><C-R>=printf("Leaderf rg %s", "")<CR>
    noremap <leader>fr :<C-U>Leaderf! --recall<CR>
    noremap <leader>fs :<C-U>Leaderf! self<CR>
    noremap ]f :<C-U>Leaderf --next<CR>
    noremap [f :<C-U>Leaderf --previous<CR>

    " vim-auto-popmenu ----------------------------------------------------{{{2
    Plug 'skywind3000/vim-auto-popmenu'
    " ins-completion 相关配置，请查看 search.vim
    " enable this plugin for filetypes, '*' for all files.
    let g:apc_enable_ft = {'*':1}
    let g:apc_enable_tab = 1
    let g:apc_min_length = 2

    " Vim-Cool ----------------------------------------------------------{{{2
    Plug 'romainl/vim-cool'
    " disables search highlighting when you are done searching and re-enables it when you search again
    let g:cool_total_matches = 1

    " Vim-quickui -------------------------------------------------------{{{2
    Plug 'skywind3000/vim-quickui'

    " Vim-quickui -------------------------------------------------------{{{2
    Plug 'skywind3000/vim-navigator'

" Note --------------------------------------------------------------------{{{1

    " Vimwiki -------------------------------------------------------------{{{2
    " Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
    " Plug 'vimwiki/vimwiki', { 'tag': 'v2.4.1' }
    Plug 'vimwiki/vimwiki', { 'commit': 'c9e6afe' }

    " def wiki dict
    let wiki = {}
    let wiki.name = 'ChenWei VimwikiMd'
    let wiki.path = 'd:/WeirdData/VimwikiMd/'
    let wiki.ext = '.md'
    let wiki.syntax = 'markdown'
    let wiki.nested_syntaxes = {'python': 'python'}
    let wiki.links_space_char = '_'
    let wiki.list_margin = 0
    let wiki.auto_toc = 1
    let wiki.auto_tags = 1
    let wiki.auto_generate_tags = 1

    " dev wiki dict for convert markdown to html
    " let wiki.template_path = 'd:/WeirdData/VimwikiMd/templates/'
    " let wiki.template_default = 'default'
    " let wiki.path_html = 'd:/WeirdData/VimwikiMd/site_html/'
    " let wiki.custom_wiki2html = 'vimwiki_markdown'
    " let wiki.template_ext = '.tpl'

    " def vimwiki_list and so on.
    let g:vimwiki_list = [wiki]
    let g:vimwiki_ext2syntax = {'.md': 'markdown'}
    let g:vimwiki_global_ext = 1
    let g:vimwiki_autowriteall = 1
    let g:vimwiki_auto_chdir = 1
    let g:vimwiki_folding = 'expr'

    " Edit ----------------------------------------------------------------{{{2

    " Repeatable surround.vim、unimpaired.vim、vim-sneak
    Plug 'tpope/vim-repeat'
    " 方便对引号等成对出现的文本进行处理
    Plug 'tpope/vim-surround'
    " 使用[和]作为先导进行导航
    Plug 'tpope/vim-unimpaired'
    " 使用gcc切换注释
    Plug 'tpope/vim-commentary'
    autocmd FileType autohotkey setlocal commentstring=;\ %s

    " table ---------------------------------------------------------------{{{2
    " 将文本按{pattern}对齐，使用 :Tabularize /{pattern}
    " video http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
    Plug 'godlygeek/tabular'
    if exists(":Tabularize")
        nmap <leader>a= :Tablularize /=<CR>
        vmap <leader>a= :Tablularize /=<CR>
        nmap <leader>a: :Tablularize /:\zs<CR>
        vmap <leader>a: :Tablularize /:\zs<CR>
    endif

    " 将文本按{pattern}转为表格，使用 :Tableize /{pattern}
    Plug 'dhruvasagar/vim-table-mode'

    " Undotree ------------------------------------------------------------{{{2
    Plug 'mbbill/undotree'
    nnoremap <Leader>u :UndotreeToggle<CR>
    " Keep undo history across sessions by storing it in a file
    if has('persistent_undo')
        if !isdirectory($HOME.'\vimfiles')
            " 0700 full permissions for the owner, no for anyone else
            call mkdir($HOME.'\vimfiles', "", 0770)
        endif
        if !isdirectory($HOME.'\vimfiles\undodir')
            call mkdir($HOME.'\vimfiles\undodir', "", 0700)
        endif
        let &undodir = $HOME . '\vimfiles\undodir'
        set undofile
    endif
    let g:undotree_WindowLayout = 3
    let g:undotree_ShortIndicators  = 1

" Program -----------------------------------------------------------------{{{1

    " Python syntax -------------------------------------------------------{{{2
    "
    " python 语法文件增强
    Plug 'vim-python/python-syntax', { 'for': ['python'] }

    " 即时代码格式化
    Plug 'skywind3000/vim-rt-format', { 'do': 'pip3 install autopep8' }
    " By default, it will be triggered by `ENTER` in insert mode.
    " set this to 1 to use `CTRL+ENTER` instead, and keep the
    " default `ENTER` behavior unchanged.
    let g:rtf_ctrl_enter = 0
    " Enable formatting when leaving insert mode
    let g:rtf_on_insert_leave = 1
    " Enable plugin for current buffer:
    " :RTFormatEnable

    " 代码格式化，支持多种语言
    Plug 'Chiel92/vim-autoformat'

    " 彩虹括号增强版
    Plug 'luochen1990/rainbow'

    " Python 补全或提醒 ---------------------------------------------------------{{{2
    " Plug 'davidhalter/jedi-vim'

    " REPL ------------------------------------------------------------{{{2
    " REPL（Read-Eval-Print Loop，读取-求值-输出的循环）是一个简单的交互式编程环境
    " Grab some text and send it to Vim Terminal： VIM ---(text)---> Vim Terminal
    Plug 'sillybun/vim-repl'
    let g:repl_program = {
                \   'python': 'ipython',
                \   'default': 'ipython',
                \   'vim': 'vim -e',
                \   }
    let g:repl_predefine_python = {
                \   'numpy': 'import numpy as np',
                \   'matplotlib': 'from matplotlib import pyplot as plt'
                \   }
    let g:repl_cursor_down = 1
    let g:repl_python_automerge = 1
    let g:repl_ipython_version = '7'
    nnoremap <leader>re :REPLToggle<Cr>
    " autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<Cr>
    " autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<Cr>
    " autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<Cr>
    let g:repl_position = 3     "0表示出现在下方，1表示出现在上方，2在左边，3在右边

    " Leader + re：打开或关闭REPL窗口，运行iPython，快捷键可配置
    " 在普通模式下按<leader>w把当前行发送到REPL窗口
    " 在普通模式下在代码块的第一行按<leader>w，把一块代码发送到REPL窗口
    " 在选择模式下选中多行代码按<leader>w把一块代码发送到REPL窗口

    " vim-terminal-help ---------------------------------------------------{{{2
    Plug 'skywind3000/vim-terminal-help'
    let g:terminal_cwd = 0
    let g:terminal_pos = 'vert botright'    " 默认为rightbelow
    let g:terminal_height = 70  " 设置高度(split，默认10)或宽度(vsplit，建议70)
    let g:terminal_kill = 'term'
    let g:terminal_close = 1

    " 在vim，使用 ALT+= 切换打开/关闭terminal
    " 在Vim和terminal，ALT+SHIFT+hjkl 用来在终端窗口和其他窗口之间跳转
    " 在terminal，使用 drop 打开文件
    " 在terminal，使用 ALT+- 粘贴 0 号复制专用寄存器
    " 在terminal，使用 ALT+q 进入normal模式，之后用i或a等则进入insert模式
    " 使用 exit 彻底退出terminal，并关闭窗口
    " let g:terminal_shell='pwsh'   " 使用PowerShell Core 7.x

" Finish ------------------------------------------------------------------{{{1
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

finish

" Inbox -------------------------------------------------------------------{{{1
    " vim-vinegar ---------------------------------------------------------{{{2
    " 评论：使用Netrw足以
    Plug 'tpope/vim-vinegar'

    " NERDTree ------------------------------------------------------------{{{2
    " 评论：使用Netrw足以
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    map <C-n> :NERDTreeToggle<CR>
    let NERDTreeChDirMode=1 "将CWD设为首次加载目录
    let NERDTreeShowBookmarks=1 "显示书签
    let NERDTreeShowLineNumbers=1   "显示行号
    let NERDTreeIgnore=['\.swp$', '\~$']

    " vim-dirvish ---------------------------------------------------------{{{2
    " 使用Netrw足以
    Plug 'justinmk/vim-dirvish'
    " Dirvish 设置：自动排序并隐藏文件，同时定位到相关文件
    " 这个排序函数可以将目录排在前面，文件排在后面，并且按照字母顺序排序
    " 比默认的纯按照字母排序更友好点。
    function! s:setup_dirvish()
        if &buftype != 'nofile' && &filetype != 'dirvish'
            return
        endif
        if has('nvim')
            return
        endif
        " 取得光标所在行的文本（当前选中的文件名）
        let text = getline('.')
        if ! get(g:, 'dirvish_hide_visible', 0)
            exec 'silent keeppatterns g@\v[\/]\.[^\/]+[\/]?$@d _'
        endif
        " 排序文件名
        exec 'sort ,^.*[\/],'
        let name = '^' . escape(text, '.*[]~\') . '[/*|@=|\\*]\=\%($\|\s\+\)'
        " 定位到之前光标处的文件
        call search(name, 'wc')
        noremap <silent><buffer> ~ :Dirvish ~<cr>
        noremap <buffer> % :e %
    endfunc
    augroup MyPluginSetup
        autocmd!
        autocmd FileType dirvish call s:setup_dirvish()
    augroup END

    " vim-airline ---------------------------------------------------------{{{2
    " 评论：严重拖慢vim启动速度
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme='lucius'

    " Smooth-Scroll -------------------------------------------------------{{{2
    " 评论：在低性能电脑中体验不好
    Plug 'terryma/vim-smooth-scroll'
    noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
    noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
    noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
    noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

    " FileTypes -----------------------------------------------------------{{{2
    " 文件类型扩展

    " powershell 脚本文件的语法高亮
    " Plug 'pprovost/vim-ps1', { 'for': 'ps1' }

    " lua 语法高亮增强
    " Plug 'tbastos/vim-lua', { 'for': 'lua' }

    " C++ 语法高亮增强，支持 11/14/17 标准
    " Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

    " 额外语法文件
    " Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

    " rust 语法增强
    " Plug 'rust-lang/rust.vim', { 'for': 'rust' }

    " vim org-mode
    " Plug 'jceb/vim-orgmode', { 'for': 'org' }

    " Tags ----------------------------------------------------------------{{{2
    " 自动生成 ctags/gtags，并提供自动索引功能
    " 不在 git/svn 内的项目，需要在项目根目录 touch 一个空的 .root 文件
    " 详细用法见：https://zhuanlan.zhihu.com/p/36279445

     " 提供 ctags/gtags 后台数据库自动更新功能
     Plug 'ludovicchabant/vim-gutentags'

     " 提供 GscopeFind 命令并自动处理好 gtags 数据库切换
     " 支持光标移动到符号名上：<leader>cg 查看定义，<leader>cs 查看引用
     Plug 'skywind3000/gutentags_plus'

     " 设定项目目录标志：除了 .git/.svn 外，还有 .root 文件
     let g:gutentags_project_root = ['.root']
     let g:gutentags_ctags_tagfile = '.tags'

     " 默认生成的数据文件集中到 ~/.cache/tags 避免污染项目目录，好清理
     let g:gutentags_cache_dir = expand('~/.cache/tags')

     " 默认禁用自动生成
     let g:gutentags_modules = []

     " 如果有 ctags 可执行就允许动态生成 ctags 文件
     if executable('ctags')
         let g:gutentags_modules += ['ctags']
     endif

     " 如果有 gtags 可执行就允许动态生成 gtags 数据库
     if executable('gtags') && executable('gtags-cscope')
         let g:gutentags_modules += ['gtags_cscope']
     endif

     " 设置 ctags 的参数
     let g:gutentags_ctags_extra_args = []
     let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
     let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
     let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

     " 使用 universal-ctags 的话需要下面这行，请反注释
     " let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

     " 禁止 gutentags 自动链接 gtags 数据库
     let g:gutentags_auto_add_gtags_cscope = 0

    " textobj -------------------------------------------------------------{{{2
    " 文本对象：textobj 全家桶

    " 基础插件：提供让用户方便的自定义文本对象的接口
    Plug 'kana/vim-textobj-user'

    " indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
    Plug 'kana/vim-textobj-indent'

    " 语法文本对象：iy/ay 基于语法的文本对象
    Plug 'kana/vim-textobj-syntax'

    " 函数文本对象：if/af 支持 c/c++/vim/java
    Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }

    " 参数文本对象：i,/a, 包括参数或者列表元素
    Plug 'sgur/vim-textobj-parameter'

    " 提供 python 相关文本对象，if/af 表示函数，ic/ac 表示类
    Plug 'bps/vim-textobj-python', {'for': 'python'}

    " 提供 uri/url 的文本对象，iu/au 表示
    Plug 'jceb/vim-textobj-uri'

    " Others --------------------------------------------------------------{{{2
    Plug 'yggdroot/indentline'
    Plug 'aaronbieber/vim-quicktask'
    Plug 'hotoo/pangu.vim'
    Plug 'arecarn/vim-crunch'
    Plug 'arecarn/vim-selection'
    Plug 'vim-scripts/VisIncr'

    " vim-pandoc ----------------------------------------------------------{{{2
    Plug 'vim-pandoc/vim-pandoc'
    let g:pandoc#spell#enabled = 0
    " let g:pandoc#spell#default_langs = ["en_us","cjk"]

    Plug 'vim-pandoc/vim-pandoc-syntax'

    " Vim-Markdown --------------------------------------------------------{{{2
    " 评论：使用Vimwiki足以
    Plug 'plasticboy/vim-markdown'
    let g:vim_markdown_toc_autofit = 1
    " let g:vim_markdown_folding_style_pythonic = 1
    " attempt to follow a named anchor in a link
    let g:vim_markdown_follow_anchor = 1

    " Python-mode ---------------------------------------------------------{{{2
    Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

    " SuperTab ------------------------------------------------------------{{{2
    " use <Tab> for all insert completion needs
    Plug 'ervandew/supertab'

    " Startuptime ---------------------------------------------------------{{{2
    Plug 'dstein64/vim-startuptime'

    " Voldikss Translator -------------------------------------------------{{{2
    Plug 'voldikss/vim-translator'
    " let g:python3_host_prog="C:\\Users\\chenw\\AppData\\Local\\Programs\\Python\\Python37\\python.exe"
    " let g:translator_debug_mode=1
    " Echo translation in the cmdline
    nmap <silent> <Leader>t <Plug>Translate
    vmap <silent> <Leader>t <Plug>TranslateV
    " Display translation in a window
    nmap <silent> <Leader>tw <Plug>TranslateW
    vmap <silent> <Leader>tw <Plug>TranslateWV
    " Replace the text with translation
    nmap <silent> <Leader>tr <Plug>TranslateR
    vmap <silent> <Leader>tr <Plug>TranslateRV

    " ECY-dictionary ------------------------------------------------------{{{2
    Plug 'hy172574895/EasyCompleteYou'
    Plug 'https://gitee.com/Jimmy_Huang/ECY-dictionary'

    " vim-dict ------------------------------------------------------------{{{2
    Plug 'skywind3000/vim-dict'
    let g:vim_dict_config = { 'vimwiki':['text'],
                            \ 'markdown':['text'],
                            \ 'vim':['vim', 'text'],
                            \ 'html':['html', 'javascript', 'css', 'text']}

    " ALE 语法检查 ----------------------------------------------------{{{2
    Plug 'dense-analysis/ale'

    " " 显示状态栏+不需要高亮行
    " let g:ale_sign_column_always = 1
    " let g:ale_set_highlights = 0
    " " 错误和警告标志
    " let g:ale_sign_error = 'x'
    " let g:ale_sign_warning = '!'
    " " 文件保存时，显示警告
    " let g:ale_lint_on_text_changed = 'never'
    " let g:ale_lint_on_enter = 0
    " " 使用对应工具进行语法检查
    let g:ale_linters = {
    \   'vimscript': ['vint'],
    \   'python': ['pylint'],
    \}
    " Snippets ------------------------------------------------------------{{{2
    " Track the engine.
    Plug 'SirVer/ultisnips'

    " Snippets are separated from the engine. Add this if you want them:
    Plug 'honza/vim-snippets'

    " Trigger configuration. Do not use <tab> if you use Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-h>"
    let g:UltiSnipsJumpBackwardTrigger="<c-l>"

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"
    " autofmt -------------------------------------------------------------{{{2
    " Vim 8.2.0901 已解决了 uax14 问题，可以不必再使用该插件了
    Plug 'vim-jp/autofmt'

    nnoremap <leader>af :call FormatexprToggle()<CR>
    function! FormatexprToggle()
        if &formatexpr == "autofmt#uax14#formatexpr()"
            setlocal formatexpr=
            echo "Don't use uax14."
        else
            setlocal formatexpr=autofmt#uax14#formatexpr()
            echo "Use uax14."
        endif
    endfunction

    nnoremap <leader>gq :call FormatPara()<CR>
    function! FormatPara()
        if &formatexpr != "autofmt#uax14#formatexpr()"
            setlocal formatexpr=autofmt#uax14#formatexpr()
        endif
        normal! vip
        normal! gq
        setlocal formatexpr=
    endfunction

    vnoremap <leader>gq :call FormatSelection()<CR>
    function! FormatSelection()
        if &formatexpr != "autofmt#uax14#formatexpr()"
            setlocal formatexpr=autofmt#uax14#formatexpr()
        endif
        normal! gv
        normal! gq
        setlocal formatexpr=
    endfunction

    " 以下要求在plug#end之后
    let s:unicode = autofmt#unicode#import()
    let s:orig_prop_line_break = s:unicode.prop_line_break
    function! s:unicode.prop_line_break(char)
        if a:char == "\u201c" || a:char == "\u2018"
            return "OP"   " Open quotations
        elseif a:char == "\u201d" || a:char == "\u2019"
            return "CL"   " Close quotations
        endif
        return call(s:orig_prop_line_break, [a:char], self)
    endfunction
    " Git -----------------------------------------------------------------{{{2
    " Plug 'tpope/vim-fugitive'

    " Python 补全或提醒 ---------------------------------------------------{{{2
    " 目前对gvim的支持有问题，不能监测vim版本，无法启动
    " Plug 'jayli/vim-easycomplete'

    " vim-sneak -----------------------------------------------------------{{{2
    " 使用两字符跨行搜索
    Plug 'justinmk/vim-sneak'
    " replace f/F with Sneak
    map f <Plug>Sneak_s
    map F <Plug>Sneak_S
    " 维持使用原始的{operator}f{char}
    onoremap <silent> f :<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>
    onoremap <silent> F :<C-U>call sneak#wrap(v:operator,   1, 1, 1, 1)<CR>
    " sneak-clever-s，可以使用s/S（f/F）进行导航，比默认的;和,更加方便
    let g:sneak#s_next = 1
    " Case sensitivity is determined by 'ignorecase' and 'smartcase'.
    let g:sneak#use_ic_scs = 1
    " Don't do any special handling of 'file manager' buffers, such as Netrw
    let g:sneak#map_netrw = 0
    " 提示符
    let g:sneak#prompt = 'sneak> '
    " YoudaoDict ----------------------------------------------------------{{{2
    Plug 'iamcco/dict.vim'
    " 翻译光标下/选中的文本，并在命令行回显
    nmap <silent> <Leader>d <Plug>DictSearch
    vmap <silent> <Leader>d <Plug>DictVSearch
    " 翻译光标下/选中的文本，并在Dict新窗口显示
    nmap <silent> <Leader>dw <Plug>DictWSearch
    vmap <silent> <Leader>dw <Plug>DictWVSearch
    " 翻译光标下/选中的文本，并替换为翻译的结果
    nmap <silent> <Leader>dr <Plug>DictRSearch
    vmap <silent> <Leader>dr <Plug>DictRVSearch
    " 使用 :Dict hello 在命令行回显
    command! -nargs=1 Dict call dict#Search(<q-args>, 'simple')
    " 使用 :DictW hello 在Dict新窗口显示
    command! -nargs=1 DictW call dict#Search(<q-args>, 'complex')
    " T.vim -------------------------------------------------------------{{{2
    Plug 'sicong-li/T.vim'
    nnoremap <leader>td :call T#Main(expand('<cword>'))<cr>
    vnoremap <leader>td :<c-u>call T#VisualSearch(visualmode())<cr>
    nnoremap <leader>tr :call T#DisplayRecent()<cr>

    " Conda activate ------------------------------------------------------{{{2
    " 使用Conda指定python环境
    Plug 'ubaldot/vim-conda-activate'
    " 命令 :CondaActivate
