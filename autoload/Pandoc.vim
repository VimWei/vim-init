" Pandoc
" 将Pandoc加入系统path:高级系统设置/高级/环境变量/path/编辑/新建/浏览/确定
" 转 pdf 还需要先安装 MiKTeX
" 打开或切换窗口到拟处理的文件
" 使用如下命令转换格式，并输出文件到CWD中
" command! PandocToPDF call Pandoc#ToPdf()
" command! PandocToDOCX call Pandoc#ToDocx()
" command! PandocToHTML call Pandoc#ToHtml()

" output_dir -------------------------------------------------------------{{{1

if IsInPlugGroup('Notetaking', 'wiki')
    let s:output_dir = g:wiki_root . "PandocOutput/"
else
    let s:output_dir = "C:/Downloads/PandocOutput/"
endif
if !isdirectory(s:output_dir)
    call mkdir(s:output_dir, "p")
endif

function! Pandoc#ToPdf() " -----------------------------------------------{{{1
    silent! w
    silent! exe "cd %:h"
    let l:PandocOutput = s:output_dir . strftime("%Y%m%d.%H%M%S") . "." . expand('%:t:r') . ".pdf"
    let l:TexTemplate = g:viminit . "tools/pandoc/template.latex"
    "CMD需要运行`chcp 65001`才能使用UTF-8编码，使用AsyncRun可避免此问题
    "-N,--number-sections; -s, --standalone; --toc, --table-of-contents; -o FILE, --output=FILE
    " 页边距设置：-V geometry:"top=1in, bottom=1in, left=1.25in, right=1.25in"
    " 默认字体：-V CJKmainfont="中文字体名"   可选：Microsoft YaHei、SimHei、SimSun
    exe ':AsyncRun Pandoc "%" -s -o ' . '"' . l:PandocOutput . '"' . ' --pdf-engine=xelatex -V CJKmainfont="SimSun" -V CJKoptions="BoldFont=SimHei" --template="' . l:TexTemplate . '"'
    echomsg "Pandoc Output File: " . l:PandocOutput
endfunction

function! Pandoc#ToDocx() " ----------------------------------------------{{{1
    " 1. 预处理
    silent! w
    silent! exe "cd %:h"
    " 2. 生成输出文件名
    let l:PandocOutput = s:output_dir . strftime("%Y%m%d.%H%M%S") . "." . expand('%:t:r') . ".docx"
    let l:ReferenceDoc = g:viminit . "tools/pandoc/reference.docx"
    " 3. 调用 Pandoc
    " exe ':AsyncRun Pandoc "%" -o ' . '"' . l:PandocOutput . '"'
    exe ':AsyncRun Pandoc "%" -o "' . l:PandocOutput . '" --reference-doc="' . l:ReferenceDoc . '"'
    echomsg "Pandoc Output File: " . l:PandocOutput
endfunction

function! Pandoc#ToDocxWithEmptyLines() " --------------------------------{{{1
    " 1. 预处理：将空行替换为 THISIS__EMPTYLINE
    silent! keeppatterns %s/^\s*$/\rTHISIS__EMPTYLINE\r/e
    silent! w
    silent! exe "cd %:h"
    " 2. 生成输出文件名
    let l:PandocOutput = s:output_dir . strftime("%Y%m%d.%H%M%S") . "." . expand('%:t:r') . ".docx"
    let l:ReferenceDoc = g:viminit . "tools/pandoc/reference.docx"
    let l:LuaFilter = g:viminit . "tools/pandoc/preserve-empty-lines.lua"
    " 3. 调用 Pandoc
    exe ':AsyncRun Pandoc "%" -o "' . l:PandocOutput . '" --reference-doc="' . l:ReferenceDoc . '" --lua-filter="' . l:LuaFilter . '"'
    " 4. 立即撤销预处理，让用户看到原文
    silent! undo
    execute 'normal! gg'
    echomsg "Pandoc Output File: " . l:PandocOutput
endfunction

function! Pandoc#ToHtml() " ----------------------------------------------{{{1
    silent! w
    silent! exe "cd %:h"
    let l:PandocOutput = s:output_dir . strftime("%Y%m%d.%H%M%S") . "." . expand('%:t:r') . ".html"
    exe ':AsyncRun Pandoc "%" -o ' . '"' . l:PandocOutput . '"'
    echomsg "Pandoc Output File: " . l:PandocOutput
endfunction
