"===================================================
" Packages config by W.Chen
" Sourced by: ../init.vim
"===================================================

" Packages ---------------------------------------------------------------{{{1
" vim 内置并自动启用的packages
let s:packages = [ 'netrw', 'vim-markdown-tpope' ]

" 增强%在配对关键字间跳转
packadd! matchit
let s:packages += [ 'matchit' ]

if has('patch-9.1.0375')
    packadd! comment
    let s:packages += [ 'comment' ]
endif

if has('patch-9.0.0000') && !has('nvim')
    packadd! vim9-stargate
    let s:packages += [ 'vim9-stargate' ]
endif

if (has('nvim-0.10') || (v:version >= 901))
    packadd! wiki.vim
    let s:packages += [ 'wiki.vim' ]
endif

if has('patch-9.1.1270')
    packadd! vim-markdown-plus
    let s:packages += [ 'vim-markdown-plus' ]
endif

packadd! vimnc
let s:packages += [ 'vimnc' ]

" source packages config -------------------------------------------------{{{1
if len(get(s:, 'packages', [])) !=# 0
    for pack in s:packages
        let pack_config = g:plugin_config_path . pack . '.vim'
        if filereadable(pack_config)
            execute 'source ' . pack_config
        endif
    endfor
endif
