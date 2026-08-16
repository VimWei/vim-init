" TypeScript folding - cached expr fold, see autoload/JsTsFold.vim
" Folds function/class/interface/type/namespace/module/enum declarations
" (with export/declare/async/abstract prefixes).
"
" Rebuild timing: folds are computed on file open and on every save
" (BufWritePost), plus :JsTsFoldRefresh for manual refresh. Editing is
" never interrupted by a full-file rescan.

if exists('b:did_jsts_fold_ftplugin')
  finish
endif
let b:did_jsts_fold_ftplugin = 1

setlocal foldmethod=expr
setlocal foldexpr=JsTsFold#Level(v:lnum)
setlocal foldtext=JsTsFold#Text()
setlocal foldlevel=1

command! -buffer JsTsFoldRefresh call JsTsFold#Refresh()

autocmd BufWritePost <buffer> call JsTsFold#Refresh()
call JsTsFold#Refresh()

let b:undo_ftplugin =
      \ get(b:, 'undo_ftplugin', '')
      \ . ' | setlocal foldmethod< foldexpr< foldtext< foldlevel<'
      \ . ' | delcommand JsTsFoldRefresh'
      \ . ' | autocmd! BufWritePost <buffer>'
      \ . ' | unlet! b:did_jsts_fold_ftplugin b:js_ts_fold_ready b:js_ts_fold_levels'
