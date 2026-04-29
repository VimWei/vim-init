" Python

" python#Run ---------------------------------------------------------------{{{1
" 使用 uv run 执行命令
" command! YourCommand call python#Run("mode", "cmd1", "cmd2", ...)
function! python#Run(...)
    " 获取第1个参数作为 AsyncRun 的 mode 参数，默认 'async'
    let l:mod = get(a:, 1, 'async')
    " 获取第2个及之后的参数作为命令，若存在，则用 ' && ' 作为分隔符拼接
    if len(a:000) >= 2
        let l:cmds = join(a:000[1:], ' && ')
    else
        let l:cmds = a:1
    endif

    let l:full_cmd = 'uv run ' . l:cmds

    if l:mod == 'async'
        execute 'AsyncRun! -mode=async -strip cmd /c "' . l:full_cmd . '"'
    elseif l:mod == 'terminal'
        execute 'AsyncRun! -mode=terminal -pos=right -raw cmd /k "' . l:full_cmd . '"'

        " 更改 Statusline 名称
        let l:termName = GetUniqueBufferName('Terminal')
        execute 'file ' . l:termName
    else
        " same as !
        execute 'AsyncRun! -mode=bang cmd /c "' . l:full_cmd . '"'
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

" python#RunFile ---------------------------------------------------------{{{1
" 运行当前 buffer 对应的文件
function! python#RunFile()
    let l:file = expand('%:p')
    call python#Run('terminal', 'python "' . l:file . '"')
endfunction

" python#SetupDLL --------------------------------------------------------{{{1
" Finds and sets $pythonthreedll for GVim on Windows. Called deferred to avoid startup flash.
function! python#SetupDLL()
    if !has('nvim') && (has('win32') || has('win64')) && has('patch-8.1.57')
        if exists('$pythonthreedll') && filereadable($pythonthreedll)
            return " Already set
        endif

        let python_dir = fnamemodify(g:python_venv_prog, ':h')
        let python_dll = ''
        
        " 1. 尝试从 pyvenv.cfg 获取 base Python 路径（uv 管理 venv 最可靠）
        let l:venv_root = fnamemodify(python_dir, ':h')
        let l:cfg_file = l:venv_root . '/pyvenv.cfg'
        if filereadable(l:cfg_file)
            for l:line in readfile(l:cfg_file)
                if l:line =~# '^home\s*='
                    let l:base_dir = substitute(l:line, '^home\s*=\s*', '', '')
                    if filereadable(l:base_dir . '\python3.dll')
                        let python_dll = l:base_dir . '\python3.dll'
                        break
                    endif
                endif
            endfor
        endif
        
        if python_dll == ''
            " 2. 检查 python.exe 同级目录
            if filereadable(python_dir . '\python3.dll')
                let python_dll = python_dir . '\python3.dll'
            endif
        endif
        
        if python_dll == ''
            " 3. 检查父目录
            let parent_dir = fnamemodify(python_dir, ':h')
            if filereadable(parent_dir . '\python3.dll')
                let python_dll = parent_dir . '\python3.dll'
            endif
        endif
        
        if python_dll == ''
            " 4. 回退查找 python3*.dll
            let dll_matches = glob(python_dir . '/python3*.dll') . "\n" . glob(parent_dir . '/python3*.dll')
            let dll_list = filter(split(dll_matches, "\n"), 'v:val !=# ""')
            if !empty(dll_list)
                let python_dll = dll_list[0]
            endif
        endif
        
        if python_dll == ''
            echohl WarningMsg
            echom "Warning: python3.dll not found. Python may not work in GVim."
            echohl None
        else
            let $pythonthreedll = python_dll
        endif
    endif
endfunction

" python#Provider --------------------------------------------------------{{{1
function! python#Provider()
    " 如果已经检查过，直接返回缓存的结果
    if exists('g:python_available')
        return g:python_available
    endif

    try
        " 优先使用项目 venv 中的 python
        if exists('g:python_venv_prog') && executable(g:python_venv_prog)
            let python_prog = fnamemodify(g:python_venv_prog, ':p')
        else
            " 回退到系统 PATH 中的 python
            if has('win32') || has('win64')
                let python_exe = 'python.exe'
            else
                let python_exe = 'python3'
            endif

            if !executable(python_exe)
                echohl WarningMsg
                echom "Warning: Python executable not found"
                echohl None
                let g:python_available = v:false
                return v:false
            endif
            let python_prog = exepath(python_exe)
        endif

        " 设置 g:python3_host_prog，可用 nvim 的 :checkhealth 检查结果
        if has('nvim')
            let g:python3_host_prog = python_prog
        endif

        call python#SetupDLL()

        let g:python_available = v:true
        return v:true
    catch
        echohl WarningMsg
        echom "Error setting up Python provider: " . v:exception
        echohl None
        let g:python_available = v:false
        return v:false
    endtry
endfunction
