" Pandoc
" 将Pandoc加入系统path:高级系统设置/高级/环境变量/path/编辑/新建/浏览/确定
" 转 pdf 还需要先安装 MiKTeX
" 打开或切换窗口到拟处理的文件
" 使用如下命令转换格式，并输出文件到CWD中
" command! PandocToPDF call Pandoc#ToPdf()
" command! PandocToDOCX call Pandoc#ToDocx()
" command! PandocToHTML call Pandoc#ToHtml()

" 获取 vim-init 所在目录，末尾带"/"
let s:viminit = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let s:viminit = substitute(s:viminit . '/', '\\', '/', 'g')

" pandoc 输出目录，末尾带"/"
if IsInPlugGroup('Notetaking', 'wiki')
    let s:output_dir = g:wiki_root . "PandocOutput/"
else
    let s:output_dir = "C:/Downloads/PandocOutput/"
endif
if !isdirectory(s:output_dir)
    call mkdir(s:output_dir, "p")
endif

function! Pandoc#ToPdf()
    silent!exe "w"
    silent!exe "cd %:h"
    let l:PandocOutput = s:output_dir . strftime("%Y%m%d.%H%M%S") . "." . expand('%:t:r') . ".pdf"
    let l:TexTemplate = s:viminit . "tools/pandoc/template.latex"
    "CMD需要运行`chcp 65001`才能使用UTF-8编码，使用AsyncRun可避免此问题
    "-N,--number-sections; -s, --standalone; --toc, --table-of-contents; -o FILE, --output=FILE
    " 页边距设置：-V geometry:"top=1in, bottom=1in, left=1.25in, right=1.25in"
    " 默认字体：-V CJKmainfont="中文字体名"   可选：Microsoft YaHei、SimHei、SimSun
    exe ':AsyncRun Pandoc "%" -s -o ' . '"' . l:PandocOutput . '"' . ' --pdf-engine=xelatex -V CJKmainfont="SimSun" --template="' . l:TexTemplate . '"'
    echomsg "Pandoc Output File: " . l:PandocOutput
endfunction

function! Pandoc#ToDocx()
    silent!exe "w"
    silent!exe "cd %:h"
    let l:PandocOutput = s:output_dir . strftime("%Y%m%d.%H%M%S") . "." . expand('%:t:r') . ".docx"
    exe ':AsyncRun Pandoc "%" -o ' . '"' . l:PandocOutput . '"'
    " silent!exe '!Pandoc "%" -o ' . '"' . l:PandocOutput . '"'
    echomsg "Pandoc Output File: " . l:PandocOutput
endfunction

function! Pandoc#ToHtml()
    silent!exe "w"
    silent!exe "cd %:h"
    let l:PandocOutput = s:output_dir . strftime("%Y%m%d.%H%M%S") . "." . expand('%:t:r') . ".html"
    exe ':AsyncRun Pandoc "%" -o ' . '"' . l:PandocOutput . '"'
    " silent!exe '!Pandoc "%" -o ' . '"' . l:PandocOutput . '"'
    echomsg "Pandoc Output File: " . l:PandocOutput
endfunction
