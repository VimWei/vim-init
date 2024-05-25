" https://github.com/kana/vim-textobj-user

" al：匹配列表文本，不包含项目符号 [*-] 和 todo 符号 [ .oOxX]，方便创建wiki link等
" il：匹配 markdown 链接的名称部分，不包括后缀名.md，方便复制并更名wiki链接页面等
call textobj#user#plugin('markdown', {
            \     'list_item_text': {
            \         'pattern': '^\s*[*-]\s\+\(\[\(\s\+\|[.oOxX]\)\]\)\?\s*\zs.*$',
            \         'select': ['al'],
            \         'scan': 'line',
            \     },
            \     'markdown_link_name': {
            \         'pattern': '\[.\{-}\](\zs.\{-}\ze\(\.md\)\?)',
            \         'select': ['il'],
            \         'scan': 'line',
            \     },
            \ })
