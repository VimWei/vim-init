" CondaPython

" 定义命令时，第1个参数是conda env名称，其他多个参数是cmd命令
" command! YourCommand call CondaPython#CondaEnv("env", "cmd1", "cmd2", "cmd3")
function! CondaPython#CondaEnv(...)
    " 切换colorscheme，以适应Terminal
    execute "LuciusDarkLowContrast"

    " 获取第1个参数作为conda环境，若没有提供，则使用 'base' 作为默认值
    let l:env = get(a:, 1, 'base')
    " 获取第2个及之后的参数作为命令，若存在，则用 ' && ' 作为分隔符拼接
    if len(a:000) >= 2
        let l:cmds = ' && ' . join(a:000[1:], ' && ')
    else
        let l:cmds = ''
    endif
    " 最后，拼接完整的命令并执行
    execute 'AsyncRun! -mode=terminal -pos=right -raw cmd /k "conda activate ' . l:env . l:cmds . '"'
    " execute 'AsyncRun! -mode=terminal -pos=thelp -raw cmd /k "conda activate ' . l:env . l:cmds . '"'
    " 使用AsyncRun! 而不是原生的terminal命令，这样可以异步执行
    " 不使用 -pos=thelp，否则无法将焦点切换到terminal，将无法正确改名statusline
    " 不使用 -pos=thelp 的缺点是，无法使用vim-terminal-help的Alt=开关terminal
    " 使用 cmd /k，而不是直接接命令，否则只会输出结果，无法继续使用terminal
    " execute 'botright vertical terminal cmd /k "conda activate ' . l:env . l:cmds . '"'
    " execute 'AsyncRun! -mode=terminal -pos=right -raw conda activate ' . l:env . l:cmds
    " execute 'AsyncRun! -mode=terminal -pos=thelp -raw python "$(VIM_FILEPATH)"'

    " 更改Statusline名称
    execute 'file Terminal'
endfunction

" 定义一个公共函数，用于处理可选的 Conda 环境参数
function! CondaPython#CondaEnvCommand(env, command, ...)
    " a:0 指函数被调用时传递的参数的数量
    if a:0 == 0
        if a:command == 'PASS'
            " 不执行命令PASS
            call CondaPython#CondaEnv(a:env)
        else
            call CondaPython#CondaEnv(a:env, a:command)
        endif
    elseif a:0 == 1
        if a:command == 'PASS'
            " 不执行命令PASS
            " a:1、a:2、a:3 等值函数被调用时传递的第1-3个参数
            call CondaPython#CondaEnv(a:1)
        else
            call CondaPython#CondaEnv(a:1, a:command)
        endif
    else
        " 若参数为2个及以上，则将参数全部传入
        let l:args = []
        for i in range(1, a:0)
            call add(l:args, get(a:, i))
        endfor
        " 如果a:1为空，则设置为默认值 a:env
        if a:1 == '""' || a:1 == ''''''
            let l:args[0] = a:env
        endif
        call call('CondaPython#CondaEnv', l:args)
    endif
endfunction

finish

" 查阅python帮助文档
function! CondaPython#PyHelpTerminal()
	" 异步输出结果到在quickfix
    " execute "AsyncRun! -raw python -c \"help('".expand("<cword>")."')\""
	" 使用异步插件AsyncRun 及 vim-terminal-help输出结果，并可以继续使用terminal
	execute "AsyncRun! -mode=terminal -pos=thelp -raw python -c \"help('".expand("<cword>")."')\""
endfunction
