" DachuBook ---------------------------------------------------------------{{{1
" 把 Markdown 笔记排成一本可打印的 PDF 书。
"
" 本文件是**薄插件**：只负责取当前文件路径、拼命令行、异步执行。
" 渲染管线在 DachuBook 里（独立 CLI），插件不做任何 Markdown 解析。
"
" 命令在 init/autoload.vim 注册：
"   :DachuBookPage   当前文件 → 单页 PDF
"   :DachuBookTree   当前文件作为入口 → 目录树 PDF（整本书）
"
" 配置（vimrc，都可选）：
"   g:dachubook_cmd       DachuBook 可执行文件，默认 "dachubook"
"   g:dachubook_config    基础配置，默认 <配置目录>/config.yaml
"                         配置目录由 `dachubook config-dir` 给出（~/.config/dachubook）
"   g:dachubook_output    产物目录，默认 <wiki_root>/.output
"
" 产物路径：<output>/<文件名>.pdf，**不再嵌套目录**。
"   例如 Health/香煎羊排.md → c:/Vimel/wiki/.output/香煎羊排.pdf
"   同名文件会互相覆盖——wiki 里的文件名本来就要求唯一。
"
" 依赖：DachuBook（uv 安装）、Chrome/Edge。
" 见 https://gitea.vimel.org/Vimel/DachuBook

let s:cmd = get(g:, 'dachubook_cmd', 'dachubook')

" 配置目录：问程序要，不自己猜平台差异 -------------------------------{{{1
function! s:ConfigDir() abort
    let l:out = system(s:cmd . ' config-dir')
    if v:shell_error != 0
        return ''
    endif
    return substitute(l:out, '[\r\n]\+$', '', '')
endfunction

function! s:ConfigPath() abort
    if exists('g:dachubook_config') && !empty(g:dachubook_config)
        return expand(g:dachubook_config)
    endif
    let l:dir = s:ConfigDir()
    return empty(l:dir) ? '' : l:dir . '/config.yaml'
endfunction

" 首次运行：生成默认配置 -----------------------------------------------{{{1
function! s:EnsureConfig() abort
    let l:config = s:ConfigPath()
    if empty(l:config)
        echohl ErrorMsg
        echomsg 'DachuBook: 找不到 ' . s:cmd . '，请确认已安装并在 PATH 中'
        echohl None
        return ''
    endif
    if filereadable(l:config)
        return l:config
    endif
    call system(s:cmd . ' init')
    if filereadable(l:config)
        echomsg 'DachuBook: 已生成默认配置 ' . l:config . '（可按需修改）'
        return l:config
    endif
    echohl ErrorMsg
    echomsg 'DachuBook: 无法生成配置 ' . l:config
    echohl None
    return ''
endfunction

" 产物路径 -------------------------------------------------------------{{{1
" <output>/<文件名>.pdf，不嵌套目录。
function! s:OutputPath() abort
    let l:dir = get(g:, 'dachubook_output', '')
    if empty(l:dir)
        let l:root = get(g:, 'wiki_root', expand('~/wiki/'))
        let l:dir = substitute(l:root, '[/\\]$', '', '') . '/.output'
    endif
    let l:dir = expand(l:dir)
    if !isdirectory(l:dir)
        call mkdir(l:dir, 'p')
    endif
    return l:dir . '/' . expand('%:t:r') . '.pdf'
endfunction

" 拼命令行 -------------------------------------------------------------{{{1
function! s:BuildArgs(config, mode, out) abort
    let l:parts = [s:cmd, 'build']
    let l:parts += ['-c', shellescape(a:config)]
    let l:parts += ['--entry', shellescape(expand('%:p'))]
    let l:parts += ['--mode', a:mode]
    let l:parts += ['--out', shellescape(a:out)]
    return join(l:parts, ' ')
endfunction

" 执行 -------------------------------------------------------------{{{1
function! s:Run(mode, label) abort
    if expand('%:e') !=# 'md'
        echohl WarningMsg | echomsg 'DachuBook: 当前文件不是 .md' | echohl None
        return
    endif
    let l:config = s:EnsureConfig()
    if empty(l:config)
        return
    endif
    silent! write
    let l:out = s:OutputPath()
    let l:cmdline = s:BuildArgs(l:config, a:mode, l:out)
    echomsg 'DachuBook: ' . a:label . ' → ' . l:out

    " Vim 按系统代码页读子进程输出，UTF-8 会显示成乱码。
    " 让程序改用系统代码页输出（见 src/dachubook/cli.py 的 DACHUBOOK_ANSI）。
    "
    " 注意语法差异：`VAR=1 cmd` 是 POSIX 的写法，cmd.exe 不认，
    " Windows 上要用 `set VAR=1 && cmd`。
    let l:env = has('win32') ? 'set DACHUBOOK_ANSI=1 && ' : 'DACHUBOOK_ANSI=1 '

    " AsyncRun 可用就用它：不阻塞编辑器
    if exists(':AsyncRun')
        execute 'AsyncRun -mode=async -cwd=' . shellescape(expand('%:p:h')) . ' ' . l:env . l:cmdline
    else
        call system(l:env . l:cmdline)
        if v:shell_error == 0
            echomsg 'DachuBook: 完成 → ' . l:out
        else
            echohl ErrorMsg | echomsg 'DachuBook: 失败，见 :messages' | echohl None
        endif
    endif
endfunction

" 对外接口 -------------------------------------------------------------{{{1
function! DachuBook#Page() abort
    call s:Run('page', '单页')
endfunction

function! DachuBook#Tree() abort
    call s:Run('tree', '目录树')
endfunction

" vim: foldmethod=marker
