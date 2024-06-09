" 打开 vim-init/init.vim 或其子目录下的 VIMRC 文档
function! Vimrc#EditInitVimrc(filename, ...) " ---------------------------{{{1
    " 根据文件名称，决定文件所在路径
    if a:filename == "init.vim"
        let l:filepath = g:viminit . a:filename
    elseif index(["vim-quickui.vim", "vim-navigator.vim"], a:filename) != -1
        let l:filepath = g:viminit . 'init/plugins.config/' . a:filename
    else
        let l:filepath = g:viminit . 'init/' . a:filename
    endif
    " 若提供了额外参数，则使用指定方案，否则使用 tabedit 打开
    let splittype = a:0 > 0 ? a:1 : 'tabedit'
    if splittype == "edit"
        execute "edit " . l:filepath
    elseif splittype == "vsp"
        execute "vert botright split " . l:filepath
    else
        " 默认打开方式，没有参数或参数错误是时的打开方式
        execute "tabedit " . l:filepath
    endif
    " 设置vim-init/为工作目录
    execute "cd " . g:viminit
endfunction

function! Vimrc#AutoReload(file) " ---------------------------------------{{{1
    if has('win32') || has('win64')
        let l:file = substitute(a:file, '\\', '/', 'g')
    else
        let l:file = a:file
    endif
    execute 'source' l:file
    echomsg 'Reloaded ' . l:file
endfunction

function! Vimrc#Update() " -----------------------------------------------{{{1
    let l:current_working_directory = getcwd()
    execute "cd " . g:viminit
    Git pull
    execute "cd " . l:current_working_directory
endfunction

" Find Plugin Config -----------------------------------------------------{{{1
function! Vimrc#PluginConfig()
    let line = getline('.')
    let pattern = '/\zs[^'']\+\ze'''
    let l:selected_text = matchstr(line, pattern)
    if empty(l:selected_text)
        if match(line, 'inbuiltplugs') != -1
            normal! yi'
            let l:selected_text = getreg('"')
        else
            echom "No plugin project found on the line."
            return
        endif
    endif
    let l:config_file = g:plugins_config_path . l:selected_text . '.vim'
    if filereadable(l:config_file)
        execute 'vsp ' . l:config_file
    else
        execute 'vnew ' . fnameescape(l:config_file)
    endif
endfunction
