" https://www.github.com/preservim/vim-textobj-sentence

let g:textobj#sentence#abbreviations = [
            \ '[ABCDIMPSUabcdegimpsv]',
            \ 'l[ab]', '[eRr]d', 'Ph', '[Ccp]l', '[Lli]n', '[cn]o',
            \ '[Oe]p', '[DJMSh]r', '[MVv]s', '[CFMPScfpw]t',
            \ 'alt', '[Ee]tc', 'div', 'es[pt]', '[Ll]td', 'min',
            \ '[MD]rs', '[Aa]pt', '[Aa]ve?', '[Ss]tr?',
            \ '[Aa]ssn', '[Bb]lvd', '[Dd]ept', 'incl', 'Inst', 'Prof', 'Univ',
            \ ]

augroup textobj_sentence
    autocmd!
    autocmd FileType markdown call textobj#sentence#init()
    autocmd FileType text call textobj#sentence#init()
augroup END
