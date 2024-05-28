" :h comment.txt
" 根据文件类型定义注释形式

autocmd FileType autohotkey setlocal commentstring=;\ %s
