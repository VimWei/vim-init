" textobjs.vim - use it with vim-textobj-user
"
" Requirement: https://github.com/kana/vim-textobj-user

call textobj#user#plugin('markdown', {
\   'list_item_text': {
\     'pattern': '^\s*\*\s\+\(\[\(\s\+\|[.oOxX]\)\]\)\?\s*\zs.*$',
\     'select': ['al'],
\   },
\   'markdown_link_name': {
\     'pattern': '\[.\{-}\](\zs.\{-}\ze\(\.md\)\?)',
\     'select': ['il'],
\   },
\ })
