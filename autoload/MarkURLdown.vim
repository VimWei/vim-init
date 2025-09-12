" 拼接当前目录下所有.log文件到当前缓冲区
function! MarkURLdown#ConcatenateLogFiles()
    " 创建新文件
    enew

    " 获取当前目录下所有.log文件列表
    let log_files = glob('*.log', 0, 1)

    if empty(log_files)
        echo "当前目录下未找到 .log 文件"
        return
    endif

    " 保存当前光标位置
    let save_cursor = getpos('.')

    " 移动到文件末尾
    call cursor(line('$'), 1)

    " 遍历所有.log文件并读取内容
    for file in log_files
        " 读取文件内容并追加到当前位置
        execute 'read ' . fnameescape(file)
    endfor

    " 1. 删除所有空行（包括只含空白字符的行）
    silent execute '%g/^\s*$/d'

    " 2. 删除所有行的第1-11个字符
    silent execute '%s/^.\{11\}//'

    " 3. 去重排序
    silent execute 'sort u'

    " 恢复原始光标位置
    call setpos('.', save_cursor)

    " 提示操作完成
    echo "已拼接并去重 " . len(log_files) . " 个.log文件"
endfunction
