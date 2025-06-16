"===================================================
" Packages config by W.Chen
" Sourced by: ../init.vim
"===================================================

" Packages ---------------------------------------------------------------{{{1
" 增强%在配对关键字间跳转
packadd! matchit
if !has('nvim')
    packadd! comment
endif

" source packages config -------------------------------------------------{{{1
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
