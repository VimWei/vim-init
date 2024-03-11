" Pandoc
" 将Pandoc加入系统path:高级系统设置/高级/环境变量/path/编辑/新建/浏览/确定
" 打开或切换窗口到拟处理的文件
" 使用如下命令转换格式，并输出文件到CWD中
" command! PandocToPDF call Pandoc#ToPdf()
" command! PandocToDOCX call Pandoc#ToDocx()
" command! PandocToHTML call Pandoc#ToHtml()

" 获取 vim-init 所在目录，不带末尾的"/"
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

" 返回tools所在路径 "s:home/path"；末尾是否包含"/"取决于path参数
function! s:path(path)
	let l:path = expand(s:home . '/' . a:path )
	return substitute(l:path, '\\', '/', 'g')
endfunction
" echo s:path('tools/conf/')

" 返回文件路径 "s:home/path/name"；为便于理解，要求path参数带末尾的"/"
function! s:cfg(path, name)
    let l:cfgpath = s:path(a:path)
    let l:cfgfile = l:cfgpath . a:name
    " return l:cfgfile
    " 转义 cfgfile 以便用作shell命令的参数，输出结果包含引号
    return shellescape(cfgfile)
endfunction
" echo s:cfg('tools/conf/', 'file.cfg')

function! Pandoc#ToPdf()
    silent!exe "w"
    silent!exe "cd %:h"
    let l:TexTemplate = s:cfg('tools/pandoc/', 'template.latex')
    let l:PandocOutput = expand('%:t:r') . "." . strftime("%Y%m%d.%H%M%S") . ".pdf"
    "CMD需要运行`chcp 65001`才能使用UTF-8编码，使用AsyncRun可避免此问题
    "-N,--number-sections; -s, --standalone; --toc, --table-of-contents; -o FILE, --output=FILE
    exe ':AsyncRun Pandoc "%" -N -s --toc -o ' . '"' . l:PandocOutput . '"' . ' --pdf-engine=xelatex --template=' . l:TexTemplate
    echomsg "Pandoc Output File: " . getcwd() . "\\" . PandocOutput
endfunction

function! Pandoc#ToDocx()
    silent!exe "w"
    silent!exe "cd %:h"
    let l:PandocOutput = expand('%:t:r') . "." . strftime("%Y%m%d.%H%M%S") . ".docx"
    " exe ':AsyncRun Pandoc "%" -o ' . '"' . l:PandocOutput . '"'
    silent!exe '!Pandoc "%" -o ' . '"' . l:PandocOutput . '"'
    echomsg "Pandoc Output File: " . getcwd() . "\\" . PandocOutput
endfunction

function! Pandoc#ToHtml()
    silent!exe "w"
    silent!exe "cd %:h"
    let l:PandocOutput = expand('%:t:r') . "." . strftime("%Y%m%d.%H%M%S") . ".html"
    " exe ':AsyncRun Pandoc "%" -o ' . '"' . l:PandocOutput . '"'
    silent!exe '!Pandoc "%" -o ' . '"' . l:PandocOutput . '"'
    echomsg "Pandoc Output File: " . getcwd() . "\\" . PandocOutput
endfunction
