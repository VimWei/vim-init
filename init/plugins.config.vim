" ref: https://github.com/iamcco/dotfiles/blob/8c2a1adeda45d76c151f480308b19c373cdd346d/nvim/viml/plugins.config.vim

scriptencoding utf-8
let s:plugins_config_path = g:viminit . 'init/plugins.config/'

" Inbuilt plugs ----------------------------------------------------------{{{1
let s:inbuiltplugs = [ 'Netrw', 'vim-markdown-tpope' ]
if len(get(s:, 'inbuiltplugs', [])) !=# 0
    for plug in s:inbuiltplugs
        let plug_config = s:plugins_config_path . plug . '.vim'
        if filereadable(plug_config)
            execute 'source ' . plug_config
        endif
    endfor
endif

" Thirdparty plugs -------------------------------------------------------{{{1
if len(get(g:, 'plugs_order', [])) !=# 0
    for plug in g:plugs_order
        let plug_config = s:plugins_config_path . plug . '.vim'
        if filereadable(plug_config)
            execute 'source ' . plug_config
        endif
    endfor
endif
