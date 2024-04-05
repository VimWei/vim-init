" 打开 vim-init/init.vim 或其子目录下的 VIMRC 文档
let s:viminit = fnamemodify(resolve(expand('<sfile>:p')), ':h:h').'/'
let s:init = fnamemodify(resolve(expand('<sfile>:p')), ':h:h') . '/init/'
function! Vimrc#EditInitVimrc(filename, ...)
    " 根据文件名称，决定文件所在路径
    if a:filename == "init.vim"
        let l:filepath = s:viminit . a:filename
    else
        let l:filepath = s:init . a:filename
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
    execute "cd " . s:viminit
endfunction