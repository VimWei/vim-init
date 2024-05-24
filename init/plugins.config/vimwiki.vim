" https://www.github.com/vimwiki/vimwiki

" def wiki dict
let wiki = {}
let wiki.name = 'Vimel Vimwiki'
let wiki.path = g:viminitparent . 'wiki/'
let wiki.ext = '.md'
let wiki.syntax = 'markdown'
let wiki.nested_syntaxes = {'python': 'python'}
let wiki.links_space_char = '_'
let wiki.list_margin = 0
let wiki.auto_toc = 1
let wiki.auto_tags = 1
let wiki.auto_generate_tags = 1

let g:vimwiki_list = [wiki]
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_global_ext = 1
let g:vimwiki_autowriteall = 1
let g:vimwiki_auto_chdir = 1

set nofoldenable
set foldlevel=1 "低于或等于的折叠默认展开，高于此折叠级别的折叠会被关闭
let g:vimwiki_folding = 'expr'
