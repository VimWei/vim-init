" 将OCRmyPDF生成的文字进行清理和规范

function! OCRmyPDF#Clean()
    :%s/ //g
    :%s/,/，/g
    " 格式化全文，并回到顶部
    exe "norm! ggVGgqgg"
endfunction
