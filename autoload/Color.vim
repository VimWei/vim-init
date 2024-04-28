" colorscheme

" Vim inbuilt colorscheme ------------------------------------------------{{{1
function! Color#RandomVimInbuiltScheme()
    let l:styles = [
        \ 'blue', 'darkblue', 'default', 'delek', 'desert',
        \ 'elflord', 'evening', 'habamax', 'industry', 'koehler',
        \ 'lunaperche', 'morning', 'murphy', 'pablo', 'peachpuff',
        \ 'quiet', 'retrobox', 'ron', 'shine', 'slate', 'sorbet',
        \ 'torte', 'wildcharm', 'zaibatsu', 'zellner',
        \ ]
    let l:random_scheme = l:styles[rand() % len(l:styles)]
    execute 'colorscheme ' . l:random_scheme
endfunction

function! RandomQuiet()
    let backgrounds = ['dark', 'light']
    let &background = backgrounds[rand() % len(backgrounds)]
    execute 'colorscheme quiet'
endfunction

" VimInit colorscheme ----------------------------------------------------{{{1
function! Color#RandomVimInitScheme()
    let l:styles = [
        \ 'call RandomLucius()',
        \ 'color borland256',
        \ 'color borlandc',
        \ 'color eclipse',
        \ 'color sublime',
        \ 'color monokai',
        \ 'color monokai-vim',
        \ 'color gaea',
        \ ]
    let l:random_scheme_cmd = l:styles[rand() % len(l:styles)]
    execute l:random_scheme_cmd
endfunction

function! RandomLucius()
    let l:styles = ['LuciusLightHighContrast', 'LuciusDarkLowContrast']
    let l:style_cmd = l:styles[rand() % len(l:styles)]
    execute 'color lucius'
    execute l:style_cmd
endfunction

" Third party colorscheme ------------------------------------------------{{{1
function! Color#RandomThirdPartyScheme()
    let l:styles = [
        \ 'call RandomXcode()',
        \ 'call RandomGruvbox8()',
        \ 'call RandomSolarized8()',
        \ 'call RandomMaterial()',
        \ 'call RandomPaperColor()',
        \ 'call RandomSonokai()',
        \ 'call RandomNord()',
        \ 'call RandomOne()',
        \ 'call RandomAfterglow()',
        \ 'color landscape',
        \ 'color gotham',
        \ 'color oceanicnext',
        \ ]
    let l:random_third_party_scheme_cmd = l:styles[rand() % len(l:styles)]
    execute l:random_third_party_scheme_cmd
endfunction

function! RandomXcode()
    let backgrounds = ['dark', 'light']
    let &background = backgrounds[rand() % len(backgrounds)]
    let l:styles = ['xcode', 'xcodehc']
    execute 'colorscheme ' . l:styles[rand() % len(l:styles)]
endfunction

function! RandomGruvbox8()
    let g:gruvbox_italics = 0
    let g:gruvbox_italicize_strings = 0
    let backgrounds = ['dark', 'light']
    let &background = backgrounds[rand() % len(backgrounds)]
    let l:styles = ['gruvbox8', 'gruvbox8_soft']
    execute 'colorscheme ' . l:styles[rand() % len(l:styles)]
endfunction

function! RandomSolarized8()
    let g:solarized_italics = 0
    let backgrounds = ['dark', 'light']
    let &background = backgrounds[rand() % len(backgrounds)]
    let l:styles = ['solarized8', 'solarized8_high', 'solarized8_low', 'solarized8_flat']
    execute 'colorscheme ' . l:styles[rand() % len(l:styles)]
endfunction

function! RandomMaterial()
    let l:styles = ['default', 'palenight', 'ocean', 'lighter', 'darker']
    let g:material_theme_style = l:styles[rand() % len(l:styles)]
    execute 'colorscheme material'
endfunction

function! RandomPaperColor()
    let backgrounds = ['dark', 'light']
    let &background = backgrounds[rand() % len(backgrounds)]
    execute 'colorscheme PaperColor'
endfunction

function! RandomSonokai()
    let g:sonokai_enable_italic = 0
    let g:sonokai_disable_italic_comment = 1
    let g:sonokai_lightline_disable_bold = 0
    let g:sonokai_better_performance = 1
    let l:styles = ['default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso']
    let g:sonokai_style = l:styles[rand() % len(l:styles)]
    execute 'colorscheme sonokai'
endfunction

function! RandomNord()
    let g:nord_underline = 1
    let g:nord_italic = 0
    let g:nord_italic_comments = 0
    execute 'colorscheme nord'
endfunction

function! RandomOne()
    let g:one_allow_italics = 0
    let backgrounds = ['dark', 'light']
    let &background = backgrounds[rand() % len(backgrounds)]
    execute 'colorscheme one'
endfunction

function! RandomAfterglow()
    let g:afterglow_use_italics=0
    let g:afterglow_blackout=1
    execute 'colorscheme afterglow'
endfunction

" Favorite colorscheme ---------------------------------------------------{{{1
function! Color#RandomFavoriteScheme(...)
    " 配置 favorite colorschemes，按启用复杂度来分类
    let l:styles_simple = [
            \ 'gaea', 'delek', 'eclipse', 'retrobox',
            \ 'borland256', 'wildcharm', 'murphy',
            \ ]
    let l:styles_complex = [
            \ 'quiet', 'lucius', 'afterglow',
            \ 'gruvbox8',
            \ ]

    " 默认行为：采用随机的colorscheme
    let l:styles = []
    for l:style in l:styles_simple
        call add(l:styles, 'color ' . l:style)
    endfor
    for l:style in l:styles_complex
        let l:firstChar = toupper(strpart(l:style, 0, 1))
        let l:restChars = strpart(l:style, 1)
        let l:style_ucfirst = l:firstChar . l:restChars
        call add(l:styles, 'call Random' . l:style_ucfirst . '()')
    endfor
    let l:colorscheme_cmd = l:styles[rand() % len(l:styles)]

    " 若指定了有效的 colorscheme，则采用该 colorscheme
    if a:0 > 0 && !empty(a:1)
        if index(l:styles_simple, a:1) >= 0
            let l:colorscheme_cmd = 'color ' . a:1
        elseif index(l:styles_complex, a:1) >= 0
            let l:firstChar = toupper(strpart(a:1, 0, 1))
            let l:restChars = strpart(a:1, 1)
            let l:style_ucfirst = l:firstChar . l:restChars
            let l:colorscheme_cmd = 'call Random' . l:style_ucfirst . '()'
        else
            let l:colorscheme_path = 'colors/' . a:1 . '.vim'
            let search_result = globpath(&runtimepath, l:colorscheme_path)
            if len(search_result) > 0
                let l:colorscheme_cmd = 'color ' . a:1
            endif
        endif
    endif

    execute l:colorscheme_cmd
endfunction

" Random colorscheme -----------------------------------------------------{{{1
let s:last_colorscheme_cmd = ''
function! Color#RandomColorScheme()
    if IsInPlugGroup('basic', 'colorscheme')
        let l:styles = [
                    \ 'call Color#RandomVimInbuiltScheme()',
                    \ 'call Color#RandomVimInitScheme()',
                    \ 'call Color#RandomFavoriteScheme()',
                    \ 'call Color#RandomThirdPartyScheme()',
                    \ ]
    else
        let l:styles = [
                    \ 'call Color#RandomVimInbuiltScheme()',
                    \ 'call Color#RandomVimInitScheme()',
                    \ 'call Color#RandomFavoriteScheme()',
                    \ ]
    endif
    let l:random_color_scheme_cmd = l:styles[rand() % len(l:styles)]
    execute l:random_color_scheme_cmd
endfunction
