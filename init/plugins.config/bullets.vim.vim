" https://www.github.com/bullets-vim/bullets.vim

let g:bullets_enabled_file_types = [ 'markdown', 'scratch' , 'text', 'wiki' ]
let g:bullets_enable_in_empty_buffers = 1
function! SmartBulletsNewlineAbove()
    let l:save_cursor = getcurpos()
    let l:current_line_num = l:save_cursor[1]
    execute "normal! \<Plug>(bullets-newline)"
    if line('.') > l:current_line_num
        execute line('.') . 'move ' . (l:current_line_num - 1)
    endif
    execute "normal! \<Plug>(bullets-renumber)"
    call setpos('.', [0, l:current_line_num, 0, 0])
    call feedkeys('A', 'i')
endfunction
let g:bullets_set_mappings = 0
let g:bullets_custom_mappings = [
    \ ['imap', '<cr>', '<Plug>(bullets-newline)'],
    \ ['inoremap', '<C-cr>', '<cr>'],
    \ ['nmap', 'o', '<Plug>(bullets-newline)'],
    \ ['nmap', 'O', ':call SmartBulletsNewlineAbove()<CR>'],
    \ ['vmap', 'glr', '<Plug>(bullets-renumber)'],
    \ ['nmap', 'glr', '<Plug>(bullets-renumber)'],
    \ ['nmap', 'glx', '<Plug>(bullets-toggle-checkbox)'],
    \ ['imap', '<C-t>', '<Plug>(bullets-demote)'],
    \ ['nmap', 'gl>', '<Plug>(bullets-demote)'],
    \ ['vmap', '>', '<Plug>(bullets-demote)'],
    \ ['imap', '<C-d>', '<Plug>(bullets-promote)'],
    \ ['nmap', 'gl<', '<Plug>(bullets-promote)'],
    \ ['vmap', '<', '<Plug>(bullets-promote)'],
\ ]

let g:bullets_delete_last_bullet_if_empty = 1
let g:bullets_line_spacing = 1
let g:bullets_pad_right = 0
let g:bullets_auto_indent_after_colon = 1
let g:bullets_max_alpha_characters = 2

let g:bullets_outline_levels = []
" let g:bullets_outline_levels += ['ROM', 'ABC']
let g:bullets_outline_levels += ['num', 'abc', 'rom']
let g:bullets_outline_levels += ['std*', 'std-', 'std+']

let g:bullets_renumber_on_change = 1
let g:bullets_nested_checkboxes = 1
let g:bullets_checkbox_markers = ' .oOX'
let g:bullets_checkbox_partials_toggle = 1
