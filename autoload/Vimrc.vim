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
    " 获取当前行内容
    let line = getline('.')

    " 构建正则表达式，匹配任意空白后的 'Plug '，然后是单引号内的内容
    let pattern = '/\zs[^'']\+\ze'''

    " 使用 matchstr 提取匹配的内容
    let l:selected_text = matchstr(line, pattern)

    " 拼接完整的配置文件路径
    let l:config_file = g:plugins_config_path . l:selected_text . '.vim'

    " 使用选中的文本执行 find 命令
    if filereadable(l:config_file)
        execute 'find ' . l:config_file
    else
        echohl ErrorMsg
        echom "File does not exist: " . l:config_file
        echohl None
    endif
endfunction
