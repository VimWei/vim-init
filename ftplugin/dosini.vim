" INI folding - folds by [section] headers
" [Section]        = level 1
" [Section.Sub]    = level 2 (dot-nested names, like TOML tables)
"
" Also powers vim9-toc (pack/mydev/opt/vim9-toc): its expr-fold collector
" turns each section header into a TOC entry.

if exists('b:did_ini_fold_ftplugin')
  finish
endif
let b:did_ini_fold_ftplugin = 1

setlocal foldmethod=expr
setlocal foldexpr=IniFoldLevel(v:lnum)
setlocal foldtext=IniFoldText()
setlocal foldlevel=1

let b:undo_ftplugin =
      \ get(b:, 'undo_ftplugin', '')
      \ . ' | setlocal foldmethod< foldexpr< foldtext< foldlevel<'
      \ . ' | unlet! b:did_ini_fold_ftplugin'

function! IniFoldLevel(lnum) abort
  let l:name = IniSectionName(getline(a:lnum))
  return empty(l:name) ? '=' : '>' . IniSectionDepth(l:name)
endfunction

function! IniSectionName(line) abort
  return matchstr(a:line, '^\s*\[\zs[^]]*\ze\]')
endfunction

function! IniSectionDepth(name) abort
  return len(split(a:name, '\.'))
endfunction

function! IniFoldText() abort
  let l:line = substitute(getline(v:foldstart), '^\s*', '', '')
  let l:line_count = v:foldend - v:foldstart + 1
  return l:line . '  [' . l:line_count . ' lines]'
endfunction
