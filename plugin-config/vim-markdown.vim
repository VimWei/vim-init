" https://www.github.com/preservim/vim-markdown

let g:vim_markdown_autowrite = 1

set nofoldenable
let g:vim_markdown_folding_disabled = 0
set foldlevel=1 "低于或等于的折叠默认展开，高于此折叠级别的折叠会被关闭
let g:vim_markdown_folding_level = 2
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_override_foldtext = 0

let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_conceal_code_blocks = 0

let g:vim_markdown_emphasis_multiline = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
au FileType markdown setlocal formatlistpat=^\\s*\\d\\+[.\)]\\s\\+\\\|^\\s*[*+~-]\\s\\+\\\|^\\(\\\|[*#]\\)\\[^[^\\]]\\+\\]:\\s | setlocal comments=n:> | setlocal formatoptions+=cn

let g:vim_markdown_toc_autofit = 1

let g:vim_markdown_fenced_languages = ['viml=vim', 'python=python', 'ahk=autohotkey']
