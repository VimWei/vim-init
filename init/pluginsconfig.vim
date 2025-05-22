"===================================================
" Packages & Plugins config by W.Chen
" Sourced by: ../init.vim
"===================================================

" Inbuilt packages & plugins config --------------------------------------{{{1
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
