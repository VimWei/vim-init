"===================================================
" Package & Plug settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Python provider --------------------------------------------------------{{{1
" 详情查阅 ../autoload/CondaPython.vim
call CondaPython#Provider()

" Packages ---------------------------------------------------------------{{{1
" 增强%在配对关键字间跳转
packadd! matchit
if !has('nvim')
    packadd! comment
endif

" plug_group -------------------------------------------------------------{{{1
" 定义快速测试分组，将覆盖下面的默认分组
" let g:plug_group = {}
" let g:plug_group['Notetaking'] = [ 'wiki' ]

" 默认情况下的分组，可以在前面覆盖之
if !exists('g:plug_group')
    let g:plug_group = {}

    let g:plug_group['basic'] = []
    let g:plug_group['basic'] += [ 'essential' ]
    let g:plug_group['basic'] += [ 'colorscheme' ]
    let g:plug_group['basic'] += [ 'guistyle' ]
    let g:plug_group['basic'] += [ 'quickui' ]
    let g:plug_group['basic'] += [ 'search' ]

    let g:plug_group['Notetaking'] = []
    let g:plug_group['Notetaking'] += [ 'edit' ]
    let g:plug_group['Notetaking'] += [ 'textobj' ]
    let g:plug_group['Notetaking'] += [ 'table' ]
    let g:plug_group['Notetaking'] += [ 'wiki' ]

    let g:plug_group['program'] = []
    let g:plug_group['program'] += [ 'git' ]
    let g:plug_group['program'] += [ 'python' ]
    let g:plug_group['program'] += [ 'LSP' ]
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

" vim-plug begin ---------------------------------------------------------{{{1
" Plug自身是一个自动延时加载函数，可放在任意&rtp/autoload目录中即可生效
" 在 Windows 下，vim的插件安装目录默认为 ~/vimfiles/plugged/
" 在 Windows 下，Neovim的插件安装目录默认为 ~/AppData/Local/nvim-data/plugged/

" vim-plug 要求 set noshellslash
set noshellslash

call plug#begin()

if IsInPlugGroup('basic', 'essential') " ---------------------------------{{{1
    Plug 'dstein64/vim-startuptime'
    Plug 'mbbill/undotree'
    Plug 'tyru/open-browser.vim'
    Plug 'jamescherti/vim-easysession'
    if has('gui_running')  && !has('nvim')
        autocmd InsertLeave * silent! set iminsert=2
    else
        Plug 'brglng/vim-im-select'
    endif
    if !has('nvim')
        Plug 'yianwillis/vimcdoc'
    end
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
    if has("gui_running") && !exists("g:neovide")
        Plug 'mattn/vimtweak'
    endif
    if has("gui_running")
        Plug 'mkropat/vim-ezguifont'
    endif
endif

if IsInPlugGroup('basic', 'quickui') " -----------------------------------{{{1
    let s:add_quickui = 0
    if has('nvim')
        if has('nvim-0.6')
            let s:add_quickui = 1
        endif
    elseif v:version >= 802 && has('patch-8.2.1')
        let s:add_quickui = 1
    endif
    if s:add_quickui
        Plug 'skywind3000/vim-quickui'
        Plug 'skywind3000/vim-navigator'
    endif
endif

if IsInPlugGroup('basic', 'search') " -----------------------------{{{1
    Plug 'skywind3000/vim-auto-popmenu'
    Plug 'easymotion/vim-easymotion'
    Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
    Plug 'ppwwyyxx/vim-PinyinSearch'
    Plug 'romainl/vim-cool'
endif

if IsInPlugGroup('Notetaking', 'edit')  " --------------------------------{{{1
    " 方便对引号等成对出现的文本进行处理
    Plug 'tpope/vim-surround'
    " 使用[和]作为先导进行导航
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-repeat'
endif

if IsInPlugGroup('Notetaking', 'textobj') " ------------------------------{{{1
    " 基础插件：提供让用户方便的自定义文本对象的接口
    Plug 'kana/vim-textobj-user'
    " indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
    Plug 'kana/vim-textobj-indent'
    " 语法文本对象：iy/ay 基于语法的文本对象
    Plug 'kana/vim-textobj-syntax'

    " Feat request：https://github.com/vim/vim/issues/14943
    " sentence 文本对象：is/as 表示句子，改进了 Mr. 等被错误识别的情形
    Plug 'preservim/vim-textobj-sentence'
    " WORD 文本对象：iW/aW，适用于vim移动命令WBE，改进对中日文等标点符号的识别
    Plug 'fuenor/jpmoveword.vim'

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

if IsInPlugGroup('Notetaking', 'wiki') " ---------------------------------{{{1
    Plug 'lervag/wiki.vim'
    Plug 'junegunn/fzf'
    Plug 'bullets-vim/bullets.vim'
    if has('nvim')
        Plug 'nvim-lua/plenary.nvim'
        Plug 'nvim-telescope/telescope.nvim'
    endif
endif

if IsInPlugGroup('program') " --------------------------------------------{{{1
    Plug 'skywind3000/vim-terminal-help'
    Plug 'skywind3000/asyncrun.vim'
    if has('nvim')
        Plug 'tpope/vim-commentary'
    endif
endif

if IsInPlugGroup('program', 'git') " -------------------------------------{{{1
    Plug 'tpope/vim-fugitive'
else
    function! g:Git_status()
        return ''
    endfunction
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
    " 快速测试代码片段
    Plug 'sillybun/vim-repl'
endif

if IsInPlugGroup('program', 'LSP') " -------------------------------------{{{1

endif

" vim-plug end -----------------------------------------------------------{{{1
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

function! ToggleShellslashForVimPlug()
  if exists('g:plugs')
    autocmd User PlugBegin set noshellslash
    autocmd User PlugEnd set shellslash
  endif
endfunction
call ToggleShellslashForVimPlug()

" Inbuilt plugins config -------------------------------------------------{{{1
let g:plugins_config_path = g:viminit . 'init/plugins.config/'

let s:inbuiltplugs = [ 'netrw', 'matchit', 'vim-markdown-tpope' ]
if !has('nvim')
    let s:inbuiltplugs += [ 'comment' ]
endif
if len(get(s:, 'inbuiltplugs', [])) !=# 0
    for plug in s:inbuiltplugs
        let plug_config = g:plugins_config_path . plug . '.vim'
        if filereadable(plug_config)
            execute 'source ' . plug_config
        endif
    endfor
endif

" Thirdparty plugins config ----------------------------------------------{{{1
if len(get(g:, 'plugs_order', [])) !=# 0
    for plug in g:plugs_order
        let plug_config = g:plugins_config_path . plug . '.vim'
        if filereadable(plug_config)
            execute 'source ' . plug_config
        endif
    endfor
endif

" Open plugin config file ------------------------------------------------{{{1
" Open plugins config path with netrw
nnoremap <leader>pc :execute 'Lexplore ' . g:plugins_config_path<CR>
" Open plugin config file with <Leader>gf or :FindPluginConfig
" Ref: ../autoload/Vimrc.vim
command! FindPluginConfig call Vimrc#PluginConfig()
nnoremap <Leader>gf :call Vimrc#PluginConfig()<CR>
" Open plugin config file with :find pluginname[tab]
