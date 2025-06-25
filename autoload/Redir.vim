" Redirect the output of a Vim or external command into a scratch buffer
" https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
" Usage:
"   :Redir messages           " 输出所有 messages
"   :Redir map                " 输出所有 map
"   :Redir !ls                " 执行外部命令 ls，输出到 scratch buffer
"   :Redir !git status        " 执行外部命令 git status，输出到 scratch buffer
"   :Redir Git pull           " 执行 Fugitive 的 :Git pull，输出到 scratch buffer
"   :Redir help user-manual   " 捕获 :help user-manual 的输出
"
"   选中多行后:
"   :Redir !sort              " 把选中行传给 sort，输出排序结果
"   :Redir !awk '{print $1}'  " 把选中行传给 awk，输出第一列
"
"   说明:
"     - 支持 Vim 内部命令、Fugitive 的 :Git 命令、外部 shell 命令（以 ! 开头）
"     - 支持 range，选中多行后可将内容作为标准输入传递给外部命令
"     - 输出结果会显示在新的 scratch buffer 中

function! Redir#redir(cmd, rng, start, end)
    for win in range(1, winnr('$'))
        if getwinvar(win, 'scratch')
            execute win . 'windo close'
        endif
    endfor
    if a:cmd =~ '^!'
        let cmd = a:cmd =~' %'
            \ ? matchstr(substitute(a:cmd, ' %', ' ' . shellescape(escape(expand('%:p'), '\')), ''), '^!\zs.*')
            \ : matchstr(a:cmd, '^!\zs.*')
        if a:rng == 0
            let output = systemlist(cmd)
        else
            let joined_lines = join(getline(a:start, a:end), '\n')
            let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
            let output = systemlist(cmd . " <<< $" . cleaned_lines)
        endif
    else
        redir => output
        execute a:cmd
        redir END
        let output = split(output, "\n")
    endif
    vnew
    let w:scratch = 1
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    call setline(1, output)
endfunction

finish

" This command definition includes -bar, so that it is possible to "chain" Vim commands.
" Side effect: double quotes can't be used in external commands
command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

" This command definition doesn't include -bar, so that it is possible to use double quotes in external commands.
" Side effect: Vim commands can't be "chained".
command! -nargs=1 -complete=command -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)
