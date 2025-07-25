" https://www.github.com/lervag/wiki.vim

" shellslash -------------------------------------------------------------{{{1
" 回车直接访问markdown的URL链接，需要禁用；其他情形，又需要启用
" set shellslash

" wiki_root --------------------------------------------------------------{{{1
let g:wiki_root = g:viminitparent . 'wiki/'

" url_transform ----------------------------------------------------------{{{1
let g:wiki_link_creation = {
    \ 'md': {
        \ 'url_transform': function('Wikivim#MyUrlTransform'),
    \ },
\ }

" wiki_templates ---------------------------------------------------------{{{1
function! JournalTemplate(context) abort
    let today = strftime("%Y-%m-%d")
    if a:context.name == today
        let title = strftime("%Y-%m-%d %A %H:%M:%S")
    else
        let timestamp = wiki#date#strptime("%Y-%m-%d", a:context.name)
        let title = strftime("%Y-%m-%d %A", timestamp)
    endif
    let template_lines = ['# ' . title] + ['']
    call append(0, template_lines)
endfunction
function! MeetingTemplate(context) abort
    let l:link = get(a:context.origin, 'link', {})
    let title = get(l:link, 'text', a:context.name)
    let template_lines = [
        \ '# ' . title,
        \ '',
        \ '* ' . strftime("%Y-%m-%d %A %H:%M:%S")
    \ ]
    call append(0, template_lines)
endfunction
function! WeeklyMealCycleTemplate(context) abort
    let l:link = get(a:context.origin, 'link', {})
    let title = get(l:link, 'text', a:context.name)
    let template_lines = [
        \ '# ' . title,
        \ '',
        \ '* ref: [Cookbook](cookbook.md)',
        \ '* ref: [Weekly MealCycle](weekly-mealcycle.md)',
        \ ''
    \ ]
    let start_date = matchstr(title, '\d\{4}-\d\{2}-\d\{2\}')
    let timestamp = wiki#date#strptime("%Y-%m-%d", start_date)
    for day in range(0, 6)
        let current_time = timestamp + day * 86400
        let date_str = strftime("%a %Y-%m-%d", current_time)
        call extend(template_lines, [
            \ '## ' . date_str,
            \ '* 早餐：',
            \ '* 午餐：',
            \ '* 晚餐：',
            \ ''
        \ ])
    endfor
    call append(0, template_lines)
    execute 'normal! gg'
endfunction
function! GeneralTemplate(context) abort
    let l:link = get(a:context.origin, 'link', {})
    let title = get(l:link, 'text', a:context.name)
    " let template_lines = ['# ' . title]
    let template_lines = [
        \ '# ' . title,
        \ '',
        \ '',
        \ '',
        \ '* Created:  ' . strftime("%Y/%m/%d %H:%M:%S"),
        \ '* Modified: ' . strftime("%Y/%m/%d %H:%M:%S")
    \ ]
    call append(0, template_lines)
    execute 'normal! Gdd3G'
endfunction
let g:wiki_templates = [
            \ { 'match_re': '^\d\{4\}-\d\{2\}-\d\{2\}$',
            \   'source_func': function('JournalTemplate') },
            \ { 'match_re': '\d\{8\}\(-\)\?' .
            \   '\(周[一二三四五六日]\|' .
            \   '\|mon\|tue\|wed\|thu\|fri\|sat\|sun' .
            \   '\|monday\|tuesday\|wednesday\|thursday\|friday\|saturday\|sunday\).*',
            \   'source_func': function('MeetingTemplate') },
            \ { 'match_re': '^周膳计划.\d\{4\}.\d\{2\}.\d\{2\}$',
            \   'source_func': function('WeeklyMealCycleTemplate') },
            \ { 'match_func': {x ->
            \       x.path_wiki !~# 'fugitive://' &&
            \       x.path_wiki !~# 'journal' },
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

" wiki_link_schemes  -----------------------------------------------------{{{1
function! WikiFileHandler(resolved, ...) abort
    if has_key(a:resolved, 'path') && filereadable(a:resolved.path)
        let ext = tolower(fnamemodify(a:resolved.path, ':e'))
        " 1. 文本类文件直接用 :edit
        if ext =~# '^\(vim\|py\|lua\|txt\|md\|json\|sh\|bat\)$'
            execute 'edit' fnameescape(a:resolved.path)
            return
        " 2. 图片用 IrfanView 打开（Windows 下）
        elseif ext =~# '^\(png\|jpg\|jpeg\|gif\|webp\)$'
            let viewer = '"C:\Program Files\IrfanView\i_view64.exe"'
            let cmd = 'start ' . viewer . ' ' . shellescape(a:resolved.path)
            silent execute '!' . cmd
            return
        " 3. PDF 用 SumatraPDF 打开
        elseif ext ==# 'pdf'
            let viewer = '"c:\Apps\SumatraPDF\SumatraPDF.exe"'
            let cmd = 'start ' . viewer . ' ' . shellescape(a:resolved.path)
            silent execute '!' . cmd
            return
        endif
        " 4. 其它类型 fallback
        echohl WarningMsg
        echomsg 'No handler for filetype: ' . ext
        echohl None
        return
    endif
    echohl WarningMsg
    echomsg 'File not found: ' . get(a:resolved, 'path', a:resolved.url)
    echohl None
endfunction

let g:wiki_link_schemes = {
        \ 'file': {
        \   'resolver': function('wiki#url#resolvers#file'),
        \   'handler': function('WikiFileHandler'),
        \ }
        \ }

" wiki_viewer ------------------------------------------------------------{{{1
let s:irfanview_path = '"C:\Program Files\IrfanView\i_view64.exe"'
let g:wiki_viewer = {
        \ 'png': 'start ' . s:irfanview_path,
        \ 'jpg': 'start ' . s:irfanview_path,
        \ 'jpeg': 'start ' . s:irfanview_path,
        \ 'gif': 'start ' . s:irfanview_path,
        \ 'webp': 'start ' . s:irfanview_path,
        \ }

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
let g:wiki_fzf_pages_opts = '--preview "type {1}"'
let g:wiki_fzf_links_opts = '--preview "type {1}"'
if has('unix')
    let g:wiki_fzf_tags_opts = '--preview "bat --color=always {2..}"'
endif

" open wiki page ---------------------------------------------------------{{{1
" 详情查阅 ../../autoload/Wikivim.vim
nnoremap <Leader>wt :call Wikivim#OpenWikiIndexTab()<CR>
command! -nargs=? VW call Wikivim#OpenWikiPage(<q-args>)
nnoremap <Leader>wi :call Wikivim#OpenWikiPage('journal.md')<CR>
nnoremap <Leader>w<Leader>i :call Wikivim#UpdateJournalIndex()<CR>
command! Inbox call Wikivim#OpenWikiPage('Inbox/inbox.md')
command! GTD call Wikivim#OpenWikiPage('GTD/gtd.md')
command! Home call Wikivim#OpenWikiPage('Home/home.md')
command! Cookbook call Wikivim#OpenWikiPage('Health/cookbook.md')
command! MealCycle call Wikivim#OpenWikiPage('Health/weekly-mealcycle.md')
command! RS call Wikivim#OpenWikiPage('Research/路演.md')
