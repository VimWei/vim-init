" textobjs.vim - use it with vim-textobj-user
"
" Requirement: https://github.com/kana/vim-textobj-user

" al：匹配列表项目的文本部分，不包含前面的 [*-]，方便创建wiki link等
" il：匹配markdown link name部分，不包括后缀名.md，方便复制该部分进行wiki页面更名等
call textobj#user#plugin('markdown', {
            \   'list_item_text': {
            \     'pattern': '^\s*[*-]\s\+\(\[\(\s\+\|[.oOxX]\)\]\)\?\s*\zs.*$',
            \     'select': ['al'],
            \   },
            \   'markdown_link_name': {
            \     'pattern': '\[.\{-}\](\zs.\{-}\ze\(\.md\)\?)',
            \     'select': ['il'],
            \   },
            \ })
