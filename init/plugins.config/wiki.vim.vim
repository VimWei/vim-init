" https://www.github.com/lervag/wiki.vim

" shellslash -------------------------------------------------------------{{{1
set shellslash

" wiki_root --------------------------------------------------------------{{{1
let g:wiki_root = g:viminitparent . 'wiki/'

" url_transform ----------------------------------------------------------{{{1
" 将wiki链接文本转为合法且清晰的文件名
function! MyUrlTransform(text)
    let l:valid_filename = substitute(a:text, '[:*\?"<>|`：!@#$%&*‘’'']', '', 'g')
    let l:formatted_filename = substitute(l:valid_filename, '\s\+\|[.。,，/+"“”<>()（）《》]', '-', 'g')
    let l:formatted_filename = substitute(l:formatted_filename, '-\+', '-', 'g')
    let l:cleaned_filename = substitute(l:formatted_filename, '^-\|-$', '', 'g')
    return tolower(l:cleaned_filename)
endfunction
let g:wiki_link_creation = {
    \ 'md': {
        \ 'url_transform': function('MyUrlTransform'),
    \ },
\ }

" wiki_templates ---------------------------------------------------------{{{1
" 为新建的各种 wiki page 创建模版
function! JournalTemplate(context) abort
    let today = strftime("%Y-%m-%d")
    if a:context.name == today
        call append(0, '# ' . strftime("%Y-%m-%d %A %H:%M:%S"))
    else
        let timestamp = wiki#date#strptime("%Y-%m-%d", a:context.name)
        let formatted_date_with_weekday = strftime("%Y-%m-%d %A", timestamp)
        call append(0, '# ' . formatted_date_with_weekday)
    endif
    call append(1, '')
    execute "normal! I## "
endfunction
function! MeetingTemplate(context) abort
    let title = get(a:context.origin.link, 'text', a:context.name)
    call append(0, '# ' . title)
    call append(1, '')
    call append(2, strftime("%Y-%m-%d %A %H:%M:%S"))
    call append(3, '')
    execute "normal! I## "
endfunction
function! GeneralTemplate(context) abort
    let title = a:context.name
    if exists('a:context.origin.link.text')
        let title = a:context.origin.link.text
    endif
    call append(0, '# ' . title)
    call append(1, '')
    execute "normal! I## "
endfunction
let g:wiki_templates = [
            \ { 'match_re': '^\d\{4\}-\d\{2\}-\d\{2\}$',
            \   'source_func': function('JournalTemplate') },
            \ { 'match_re': '\d\{8\}\(-\)\?' .
            \   '\(周[一二三四五六日]\|' .
            \   '\|mon\|tue\|wed\|thu\|fri\|sat\|sun' .
            \   '\|monday\|tuesday\|wednesday\|thursday\|friday\|saturday\|sunday\).*',
            \   'source_func': function('MeetingTemplate') },
            \ { 'match_func': { x -> x.path_wiki !~# 'journal' },
            \   'source_func': function('GeneralTemplate') },
            \]

" wiki_journal -----------------------------------------------------------{{{1
let g:wiki_journal = {
    \ 'date_format': {
            \ 'daily' : '%Y/%Y-%m-%d',
            \ 'weekly' : '%Y/%Y_w%V',
            \ 'monthly' : '%Y/%Y_m%m',
            \ },
    \}
let g:wiki_journal_index = {
    \ 'reverse': v:true,
    \ 'link_text_parser': { b, d, p -> wiki#toc#get_page_title(p) },
    \}
let g:wiki_mappings_local_journal = {
    \ '<plug>(wiki-journal-prev)' : '[w',
    \ '<plug>(wiki-journal-next)' : ']w',
    \}

" wiki_export ------------------------------------------------------------{{{1
let s:TexTemplate = g:viminit . "tools/pandoc/template.latex"
let s:pandocargs = '--pdf-engine=xelatex -V CJKmainfont="SimSun" --template="' . s:TexTemplate . '"'
let g:wiki_export = {
        \ 'args' : s:pandocargs,
        \ 'from_format' : 'markdown',
        \ 'ext' : 'pdf',
        \ 'link_ext_replace': v:false,
        \ 'view' : v:false,
        \ 'output': 'PandocOutput',
        \}

" fzf --------------------------------------------------------------------{{{1
let g:wiki_fzf_pages_opts = '--preview "cat {1}"'
let g:wiki_fzf_links_opts = '--preview "cat {1}"'
if has('unix')
    let g:wiki_fzf_tags_opts = '--preview "bat --color=always {2..}"'
endif

" open wiki page ---------------------------------------------------------{{{1
" 详情查阅 ../../autoload/Wikivim.vim
nnoremap <Leader>wt :call Wikivim#OpenWikiIndexTab()<CR>
command! -nargs=? VW call Wikivim#OpenWikiPage(<q-args>)
command! RS call Wikivim#OpenWikiPage('Research/路演.md')
nnoremap <Leader>wi :call Wikivim#OpenWikiPage('journal.md')<CR>
nnoremap <Leader>w<Leader>i :call Wikivim#UpdateJournalIndex()<CR>
