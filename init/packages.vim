"===================================================
" Packages config by W.Chen
" Sourced by: ../init.vim
"===================================================

" Packages ---------------------------------------------------------------{{{1
let s:inbuiltplugs = [ 'netrw', 'vim-markdown-tpope' ]

" 增强%在配对关键字间跳转
packadd! matchit
let s:inbuiltplugs += [ 'matchit' ]

if !has('nvim')
    packadd! comment
    let s:inbuiltplugs += [ 'comment' ]
endif

" source packages config -------------------------------------------------{{{1
if len(get(s:, 'inbuiltplugs', [])) !=# 0
    for plug in s:inbuiltplugs
        let plug_config = g:plugin_config_path . plug . '.vim'
        if filereadable(plug_config)
            execute 'source ' . plug_config
        endif
    endfor
endif
