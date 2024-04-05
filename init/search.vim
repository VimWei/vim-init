"===================================================
" Search and ins-completion settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Search related ----------------------------------------------------------{{{1
set path+=**    "Search down into subfolders, :find and etc.
set ignorecase  "忽略大小写敏感
set smartcase   "智能大小写：以小写开头则不敏感，以大写开头则敏感
set hlsearch    "高亮显示所有匹配的搜索结果
set incsearch   "在未完全输入完毕要搜索的文本时就显示相应的匹配点
set showmatch   "高亮显示匹配的括号
set matchtime=2 "显示配对括号的十分之一秒数

" ins-completion related --------------------------------------------------{{{1
" set complete=.,t,k,w,b,u,i  " 补全来源及优先级
set complete=.,t,k  " 补全来源及优先级
set completeopt=menu,menuone,noselect   " don't select the first item.
set infercase       " 匹配的大小写会根据输入进行调整
set shortmess+=c    " suppress annoy messages.

" 指定字典文件，可以使用CTRL-X CTRL-K调用
let s:viminit = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let s:viminit = substitute(s:viminit . '/', '\\', '/', 'g')
" 综合高频前20K及其变形，合计40多K
exec 'set dictionary+='.s:viminit.'tools/dict/WordMax2K.dict'

" 文件搜索和补全时忽略下面扩展名 ------------------------------------------{{{1
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
