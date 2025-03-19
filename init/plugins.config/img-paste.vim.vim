" https://github.com/img-paste-devs/img-paste.vim

" map --------------------------------------------------------------------{{{1
autocmd FileType markdown nmap <buffer><silent> <leader>ip :call mdip#MarkdownClipboardImage()<CR>

" default image directory and image name ---------------------------------{{{1
" let g:mdip_imgdir = 'img'
" let g:mdip_imgname = 'image'
