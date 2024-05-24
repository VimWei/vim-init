"===================================================
" Package & Plug settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" plug_group -------------------------------------------------------------{{{1
" 定义快速测试分组，将覆盖下面的默认分组
" let g:plug_group = {}
" let g:plug_group['Notetaking'] = [ 'wiki' ]

" 默认情况下的分组，可以在前面覆盖之
if !exists('g:plug_group')
    let g:plug_group = {}
    let g:plug_group['inbox'] = []

    let g:plug_group['basic'] = []
    let g:plug_group['basic'] += [ 'startup', 'essential' ]
    let g:plug_group['basic'] += [ 'colorscheme' ]
    if has("gui_running") && !exists("g:neovide")
        let g:plug_group['basic'] += [ 'guistyle' ]
    endif

    let s:add_quickui = 0
    if has('nvim')
        if has('nvim-0.6')
            let s:add_quickui = 1
        endif
    elseif v:version >= 802 && has('patch-8.2.1')
        let s:add_quickui = 1
    endif
    if s:add_quickui
        let g:plug_group['basic'] += [ 'quickui' ]
    endif

    let g:plug_group['basic'] += [ 'session' ]

    let g:plug_group['search'] = []
    let g:plug_group['search'] += [ 'auto-popmenu', 'EasyMotion', 'Leaderf' ]
    let g:plug_group['search'] += [ 'pinyin', 'vim-cool' ]

    let g:plug_group['Notetaking'] = []
    let g:plug_group['Notetaking'] += [ 'edit', 'textobj' ]
    let g:plug_group['Notetaking'] += [ 'table' ]
    let g:plug_group['Notetaking'] += [ 'list' ]
    " let g:plug_group['Notetaking'] += [ 'vimwiki' ]
    let g:plug_group['Notetaking'] += [ 'wiki' ]
    " let g:plug_group['Notetaking'] += [ 'markdown' ]

    let g:plug_group['program'] = []
    let g:plug_group['program'] += [ 'git' ]
    let g:plug_group['program'] += [ 'terminal', 'AsyncRun' ]
    let g:plug_group['program'] += [ 'python', 'REPL' ]
endif

function! IsInPlugGroup(group, ...)
    if a:0 > 0 " Check if there is more than one argument
        let item = a:1
        return has_key(g:plug_group, a:group)
               \ && index(g:plug_group[a:group], item) >= 0
    else
        return has_key(g:plug_group, a:group)
    endif
endfunction

" Python provider --------------------------------------------------------{{{1
" 详情查阅 ../autoload/CondaPython.vim

call CondaPython#Provider()

" Packages ---------------------------------------------------------------{{{1
" 增强%在配对关键字间跳转
packadd! matchit

" vim-plug begin ---------------------------------------------------------{{{1
" Plug自身是一个自动延时加载函数，可放在任意&rtp/autoload目录中即可生效
" 在 Windows 下，其所管理的插件安装目录默认为 ~/vimfiles/plugged/

" 解决：wiki.vim 要求 set shellslash，但 vim-plug 要求 set noshellslash
function! ToggleShellslashForVimPlug()
  if exists('g:plugs')
    autocmd User PlugBegin set noshellslash
    autocmd User PlugEnd set shellslash
  endif
endfunction

set noshellslash

call plug#begin()

if IsInPlugGroup('inbox') " ----------------------------------------------{{{1
    " 插件试验场
endif

if IsInPlugGroup('basic', 'startup') " -----------------------------------{{{1
    Plug 'dstein64/vim-startuptime'
    if !has('nvim')
        Plug 'yianwillis/vimcdoc'
    end
endif

if IsInPlugGroup('basic', 'essential') " ---------------------------------{{{1
    Plug 'mbbill/undotree'
    Plug 'tyru/open-browser.vim'
    if has('gui_running')  && !has('nvim')
        autocmd InsertLeave * silent! set iminsert=2
    else
        Plug 'brglng/vim-im-select'
    endif
endif

if IsInPlugGroup('basic', 'colorscheme') " -------------------------------{{{1
    Plug 'lifepillar/vim-solarized8'
    Plug 'lifepillar/vim-gruvbox8'
    Plug 'kaicataldo/material.vim'
    Plug 'sainnhe/sonokai'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'rakr/vim-one'
    Plug 'itchyny/landscape.vim'
    Plug 'arcticicestudio/nord-vim'
    Plug 'whatyouhide/vim-gotham'
    Plug 'adrian5/oceanic-next-vim'
    Plug 'arzg/vim-colors-xcode'
    Plug 'danilo-augusto/vim-afterglow'
    Plug 'tomasiser/vim-code-dark'

    Plug 'zefei/vim-colortuner'
    Plug 'lifepillar/vim-colortemplate'
    Plug 'skywind3000/vim-color-patch'
    if has('nvim')
        Plug 'skywind3000/vim-color-export'
    endif
endif

if IsInPlugGroup('basic', 'guistyle') " ----------------------------------{{{1
    Plug 'mattn/vimtweak'
endif

if IsInPlugGroup('basic', 'quickui') " -----------------------------------{{{1
    Plug 'skywind3000/vim-quickui'
    Plug 'skywind3000/vim-navigator'
endif

if IsInPlugGroup('basic', 'session') " -----------------------------------{{{1
    Plug 'jamescherti/vim-easysession'
endif

if IsInPlugGroup('search', 'auto-popmenu') " -----------------------------{{{1
    Plug 'skywind3000/vim-auto-popmenu'
endif

if IsInPlugGroup('search', 'EasyMotion')  " ------------------------------{{{1
    Plug 'easymotion/vim-easymotion'
endif

if IsInPlugGroup('search', 'Leaderf')  " ---------------------------------{{{1
    Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
endif

if IsInPlugGroup('search', 'pinyin')  " ----------------------------------{{{1
    Plug 'ppwwyyxx/vim-PinyinSearch'
endif

if IsInPlugGroup('search', 'vim-cool')  " --------------------------------{{{1
    Plug 'romainl/vim-cool'
endif

if IsInPlugGroup('Notetaking', 'edit')  " --------------------------------{{{1
    Plug 'tpope/vim-commentary'
    " 方便对引号等成对出现的文本进行处理
    Plug 'tpope/vim-surround'
    " 使用[和]作为先导进行导航
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-repeat'
endif

if IsInPlugGroup('Notetaking', 'textobj') " ------------------------------{{{1
    " 基础插件：提供让用户方便的自定义文本对象的接口
    " 详情查阅 ../plugin/textobjs.vim
    Plug 'kana/vim-textobj-user'
    " indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
    Plug 'kana/vim-textobj-indent'
    " 语法文本对象：iy/ay 基于语法的文本对象
    Plug 'kana/vim-textobj-syntax'
    " 函数文本对象：if/af 支持 c/c++/vim/java
    Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
    " 提供 python 相关文本对象，if/af 表示函数，ic/ac 表示类
    Plug 'bps/vim-textobj-python', {'for': 'python'}
endif

if IsInPlugGroup('Notetaking', 'table')  " -------------------------------{{{1
    " 将文本按{pattern}对齐，使用 :Tabularize /{pattern}
    Plug 'godlygeek/tabular'
    " 将文本按{pattern}转为表格，使用 :Tableize /{pattern}
    Plug 'dhruvasagar/vim-table-mode'
endif

if IsInPlugGroup('Notetaking', 'list')  " --------------------------------{{{1
    Plug 'bullets-vim/bullets.vim'
endif

if IsInPlugGroup('Notetaking', 'vimwiki') " ------------------------------{{{1
    " Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
    " Plug 'vimwiki/vimwiki', { 'tag': 'v2.4.1' }
    Plug 'vimwiki/vimwiki', { 'commit': 'c9e6afe' }
endif

if IsInPlugGroup('Notetaking', 'wiki') " ---------------------------------{{{1
    Plug 'lervag/wiki.vim'
    Plug 'junegunn/fzf'
endif

if IsInPlugGroup('Notetaking', 'markdown') " -----------------------------{{{1
    Plug 'preservim/vim-markdown'
endif

if IsInPlugGroup('program', 'git') " -------------------------------------{{{1
    Plug 'tpope/vim-fugitive'
else
    function! g:Git_status()
        return ''
    endfunction
endif

if IsInPlugGroup('program', 'terminal')  " -------------------------------{{{1
    Plug 'skywind3000/vim-terminal-help'
endif

if IsInPlugGroup('program', 'AsyncRun') " --------------------------------{{{1
    Plug 'skywind3000/asyncrun.vim'
endif

if IsInPlugGroup('program', 'python') " ----------------------------------{{{1
    " python 语法文件增强
    Plug 'vim-python/python-syntax', { 'for': ['python'] }

    " 即时代码格式化
    Plug 'skywind3000/vim-rt-format', { 'do': 'pip3 install autopep8' }

    " 代码格式化，支持多种语言
    Plug 'Chiel92/vim-autoformat'

    " 彩虹括号增强版
    Plug 'luochen1990/rainbow'
endif

if IsInPlugGroup('program', 'REPL') " ------------------------------------{{{1
    Plug 'sillybun/vim-repl'
endif

" vim-plug end -----------------------------------------------------------{{{1
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set shellslash
call ToggleShellslashForVimPlug()

finish " -----------------------------------------------------------------{{{1

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

    " vim-pandoc ----------------------------------------------------------{{{2
    Plug 'vim-pandoc/vim-pandoc'
    let g:pandoc#spell#enabled = 0
    " let g:pandoc#spell#default_langs = ["en_us","cjk"]

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

    " T.vim -------------------------------------------------------------{{{2
    Plug 'sicong-li/T.vim'
    nnoremap <leader>td :call T#Main(expand('<cword>'))<cr>
    vnoremap <leader>td :<c-u>call T#VisualSearch(visualmode())<cr>
    nnoremap <leader>tr :call T#DisplayRecent()<cr>
