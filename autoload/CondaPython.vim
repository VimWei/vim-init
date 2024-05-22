" CondaPython

" CondaPython#CondaEnv ---------------------------------------------------{{{1
" 定义命令时，第1-2个参数是conda env和asyncrun mode，其他多个参数是cmd命令
" command! YourCommand call CondaPython#CondaEnv("env", "mode", "cmd1", "cmd2", ...)
function! CondaPython#CondaEnv(...)
    " 切换colorscheme，以适应Terminal
    " execute 'colorscheme wildcharm'

    " 获取第1个参数作为conda环境，默认 'base'
    let l:env = get(a:, 1, 'base')
    " 获取第2个参数作为AsyncRun的mode参数，默认 'async'，其他选项有 terminal 和 bang
    let l:mod = get(a:, 2, 'async')
    " 获取第3个及之后的参数作为命令，若存在，则用 ' && ' 作为分隔符拼接
    if len(a:000) >= 3
        let l:cmds = ' && ' . join(a:000[2:], ' && ')
    else
        let l:cmds = ''
    endif
    " 最后，拼接完整的命令并执行
    if l:mod == 'async'
        execute 'AsyncRun! -mode=async -strip cmd /c "conda activate ' . l:env . l:cmds . '"'
    elseif l:mod == 'terminal'
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
        let l:termName = GetUniqueBufferName('Terminal')
        execute 'file ' . l:termName
    else
        " same as !
        execute 'AsyncRun! -mode=bang cmd /c "conda activate ' . l:env . l:cmds . '"'
    endif
endfunction

" GetUniqueBufferName ----------------------------------------------------{{{1
" 用于生成不重复的名称
function! GetUniqueBufferName(baseName)
    let l:counter = 1
    let l:uniqueName = a:baseName
    while bufexists(l:uniqueName)
        let l:uniqueName = a:baseName . ' ' . l:counter
        let l:counter += 1
    endwhile
    return l:uniqueName
endfunction

" CondaPython#CondaEnvCommand --------------------------------------------{{{1
" 定义一个公共函数，用于处理可选的 Conda 环境参数
function! CondaPython#CondaEnvCommand(env, mode, command, ...)
    " a:0 指函数被调用时传递的参数的数量
    if a:0 == 0
        if a:command == 'PASS'
            " 不执行命令PASS
            call CondaPython#CondaEnv(a:env, a:mode)
        else
            call CondaPython#CondaEnv(a:env, a:mode, a:command)
        endif
    elseif a:0 == 1
        if a:command == 'PASS'
            " 不执行命令PASS
            " a:1、a:2、a:3 等值函数被调用时传递的第1-3个参数
            call CondaPython#CondaEnv(a:1, a:mode)
        else
            call CondaPython#CondaEnv(a:1, a:mode, a:command)
        endif
    elseif a:0 == 2
        if a:command == 'PASS'
            " 不执行命令PASS
            " a:1、a:2、a:3 等值函数被调用时传递的第1-3个参数
            call CondaPython#CondaEnv(a:1, a:2)
        else
            call CondaPython#CondaEnv(a:1, a:2, a:command)
        endif
    else
        " 若参数为3个及以上，则将参数全部传入
        let l:args = []
        for i in range(1, a:0)
            call add(l:args, get(a:, i))
        endfor
        " 如果a:1为空，则设置为默认值 a:env
        if a:1 == '""' || a:1 == ''''''
            let l:args[0] = a:env
        endif
        if a:2 == '""' || a:2 == ''''''
            let l:args[1] = a:mode
        endif
        call call('CondaPython#CondaEnv', l:args)
    endif
endfunction

" CondaPython#Help -------------------------------------------------------{{{1
" 查阅python帮助文档
function! CondaPython#Help()
    " 若要异步输出结果到在quickfix，则更改 terminal 为 async
    let l:command = "python -c \"help('".expand("<cword>")."')\""
    call CondaPython#CondaEnvCommand('pymotw', 'terminal', l:command)
endfunction

" Python provider --------------------------------------------------------{{{1
" 在nvim下可以使用 :checkhealth 检查
function! CondaPython#Provider()
    " 使用系统命令查找 Python 可执行文件的路径
    if has('win32') || has('win64')
        let python_cmd = 'where python'
        let dll_name = 'python3.dll'
    else
        let python_cmd = 'which python3'
        let dll_name = has('macunix') ? 'libpython3.dylib' : 'libpython3.so'
    endif

    let python_prog = split(trim(system(python_cmd)), "\n")[0]
    if !empty(python_prog)
        " 设置 g:python3_host_prog
        if has('nvim')
            let g:python3_host_prog = python_prog
        endif

        " 在 Windows 上设置 PYTHONTHREEDLL
        if has('win32') || has('win64')
            let python_dll = fnamemodify(python_prog, ':h') . '/' . dll_name
            if filereadable(python_dll)
                let $PYTHONTHREEDLL = python_dll
            else
                echoerr "Warning: " . dll_name . " not found near the python executable"
            endif
        endif
    else
        echoerr "Warning: Python executable not found"
    endif
endfunction
