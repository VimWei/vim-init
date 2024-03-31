"===================================================
" Package & Plug settings by W.Chen
" Sourced by: ../init.vim
"===================================================

"激活matchit，增强%在配对关键字间跳转
packadd! matchit

" ToggleShellslashForVimPlug ----------------------------------------------{{{1

" 解决：wiki.vim 要求 set shellslash，但 vim-plug 要求 set noshellslash
function! ToggleShellslashForVimPlug()
  if exists('g:plugs')
    autocmd User PlugBegin set noshellslash
    autocmd User PlugEnd set shellslash
  endif
endfunction

" vim-plug begin ----------------------------------------------------------{{{1
" Plug自身是一个自动延时加载函数，可放在任意&rtp/autoload目录中即可生效
" 在 Win10 下，其所管理的插件安装目录默认为 ~/vimfiles/plugged/

set noshellslash

call plug#begin()

" Basic -------------------------------------------------------------------{{{1

    " Startuptime ---------------------------------------------------------{{{2
    Plug 'dstein64/vim-startuptime'

    " ColorScheme ---------------------------------------------------------{{{2
    Plug 'lifepillar/vim-solarized8'
    Plug 'lifepillar/vim-gruvbox8'
    Plug 'kaicataldo/material.vim'
    Plug 'sainnhe/sonokai'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'rakr/vim-one'
    Plug 'itchyny/landscape.vim'
    Plug 'arcticicestudio/nord-vim'

    Plug 'zefei/vim-colortuner'
    Plug 'lifepillar/vim-colortemplate'
    Plug 'skywind3000/vim-color-patch'
    " 按需在cpatch_path目录下构建colorscheme同名的文件
    let s:viminit = fnamemodify(resolve(expand('<sfile>:p')), ':h:h').'/'
    let g:cpatch_path = s:viminit . 'colors/patch'

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
    " map <C-n> :Lexplore %:p:h<CR>
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

    " fzf -----------------------------------------------------------------{{{2
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

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

    " Vim-navigator -----------------------------------------------------{{{2
    Plug 'skywind3000/vim-navigator'

" Note --------------------------------------------------------------------{{{1

    " wiki ----------------------------------------------------------------{{{2
    Plug 'lervag/wiki.vim'
    let g:wiki_root = expand("<sfile>:p:h:h:h") . "/wiki/"
    augroup wiki_vim_autochdir
        autocmd!
        autocmd BufEnter *.md,*.wiki if getbufvar(expand('%'), '&filetype') == 'markdown' | execute 'cd ' . g:wiki_root | endif
    augroup END

    let g:wiki_journal = {
          \ 'name': 'journal',
          \ 'root': '',
          \ 'frequency': 'daily',
          \ 'date_format': {
          \   'daily' : '%Y/%Y-%m-%d',
          \   'weekly' : '%Y/%Y_w%V',
          \   'monthly' : '%Y/%Y_m%m',
          \ },
          \}
    let g:wiki_link_creation = {
          \ 'md': { 'link_type': 'md', 'url_extension': '' },
          \ 'org': { 'link_type': 'org', 'url_extension': '.org' },
          \ 'adoc': { 'link_type': 'adoc_xref_bracket', 'url_extension': '' },
          \ '_': { 'link_type': 'wiki', 'url_extension': '' },
          \}

    let g:wiki_journal_index = {
          \ 'link_text_parser': { b, d, p -> wiki#toc#get_page_title(p) }
          \}

    let g:wiki_mappings_global = {
          \ '<plug>(wiki-page-toc)' : '',
          \}
    let g:wiki_mappings_local_journal = {
          \ '<plug>(wiki-journal-prev)' : '[w',
          \ '<plug>(wiki-journal-next)' : ']w',
          \}

    let g:markdown_folding = 1

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

    " Vim-Markdown --------------------------------------------------------{{{2
    Plug 'preservim/vim-markdown'

    let g:vim_markdown_autowrite = 1

    set nofoldenable
    let g:vim_markdown_folding_disabled = 0
    set foldlevel=1 "低于或等于的折叠默认展开，高于此折叠级别的折叠会被关闭
    let g:vim_markdown_folding_level = 2
    let g:vim_markdown_folding_style_pythonic = 1
    let g:vim_markdown_override_foldtext = 0

    set conceallevel=2
    let g:tex_conceal = ""
    let g:vim_markdown_math = 1
    let g:vim_markdown_conceal_code_blocks = 0

    let g:vim_markdown_emphasis_multiline = 1
    let g:vim_markdown_strikethrough = 1
    let g:vim_markdown_auto_insert_bullets = 1
    let g:vim_markdown_new_list_item_indent = 0

    let g:vim_markdown_toc_autofit = 1

    let g:vim_markdown_fenced_languages = ['viml=vim', 'python=python', 'ahk=autohotkey']

    " bullets -------------------------------------------------------------{{{2
    Plug 'bullets-vim/bullets.vim'
    let g:bullets_enabled_file_types = [ 'markdown', 'scratch' , 'text', 'vimwiki' ]
    let g:bullets_enable_in_empty_buffers = 1
    function! SmartBulletsNewlineAbove()
        let l:save_cursor = getcurpos()
        let l:current_line_num = l:save_cursor[1]
        execute "normal! \<Plug>(bullets-newline)"
        if line('.') > l:current_line_num
            execute line('.') . 'move ' . (l:current_line_num - 1)
        endif
        execute "normal! \<Plug>(bullets-renumber)"
        call setpos('.', [0, l:current_line_num, 0, 0])
        call feedkeys('A', 'n')
    endfunction
    let g:bullets_set_mappings = 0
    let g:bullets_custom_mappings = [
        \ ['imap', '<cr>', '<Plug>(bullets-newline)'],
        \ ['inoremap', '<C-cr>', '<cr>'],
        \ ['nmap', 'o', '<Plug>(bullets-newline)'],
        \ ['nmap', 'O', ':call SmartBulletsNewlineAbove()<CR>'],
        \ ['vmap', 'glr', '<Plug>(bullets-renumber)'],
        \ ['nmap', 'glr', '<Plug>(bullets-renumber)'],
        \ ['nmap', 'glx', '<Plug>(bullets-toggle-checkbox)'],
        \ ['imap', '<C-t>', '<Plug>(bullets-demote)'],
        \ ['nmap', 'gl>', '<Plug>(bullets-demote)'],
        \ ['vmap', '>', '<Plug>(bullets-demote)'],
        \ ['imap', '<C-d>', '<Plug>(bullets-promote)'],
        \ ['nmap', 'gl<', '<Plug>(bullets-promote)'],
        \ ['vmap', '<', '<Plug>(bullets-promote)'],
    \ ]

    let g:bullets_delete_last_bullet_if_empty = 1
    let g:bullets_line_spacing = 1
    let g:bullets_pad_right = 0
    let g:bullets_auto_indent_after_colon = 1
    let g:bullets_max_alpha_characters = 2
    " let g:bullets_outline_levels = ['ROM', 'ABC', 'num', 'abc', 'rom', 'std*', 'std-', 'std+']
    let g:bullets_outline_levels = ['num', 'std*', 'std-', 'std+']
    let g:bullets_renumber_on_change = 1
    let g:bullets_nested_checkboxes = 1
    let g:bullets_checkbox_markers = ' .oOX'
    let g:bullets_checkbox_partials_toggle = 1

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

    " Git -----------------------------------------------------------------{{{2
    Plug 'tpope/vim-fugitive'

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

" vim-plug end ------------------------------------------------------------{{{1
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set shellslash
call ToggleShellslashForVimPlug()
