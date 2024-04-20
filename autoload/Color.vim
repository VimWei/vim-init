" colorscheme

" Vim inbuilt colorscheme -------------------------------------------------{{{1
function! Color#RandomVimInbuiltScheme()
    let l:styles = [
        \ 'blue', 'darkblue', 'default', 'delek', 'desert',
        \ 'elflord', 'evening', 'habamax', 'industry', 'koehler',
        \ 'lunaperche', 'morning', 'murphy', 'pablo', 'peachpuff',
        \ 'quiet', 'retrobox', 'ron', 'shine', 'slate', 'sorbet',
        \ 'torte', 'wildcharm', 'zaibatsu', 'zellner',
        \ ]
    let l:random_vim_inbuild_scheme = l:styles[rand() % len(l:styles)]
    execute 'colorscheme ' . l:random_vim_inbuild_scheme
endfunction

" Third party colorscheme -------------------------------------------------{{{1
function! Color#RandomThirdPartyScheme()
    let l:styles = [
        \ 'call RandomLucius()',
        \ 'call RandomGruvbox8()',
        \ 'call RandomSolarized8()',
        \ 'call RandomMaterial()',
        \ 'call RandomPaperColor()',
        \ 'call RandomSonokai()',
        \ 'call RandomNord()',
        \ 'call RandomOne()',
        \ 'color landscape',
        \ 'color gotham',
        \ 'color oceanicnext',
        \ ]
    let l:random_third_party_scheme_cmd = l:styles[rand() % len(l:styles)]
    execute l:random_third_party_scheme_cmd
endfunction

function! RandomLucius()
    let l:styles = ['LuciusLightHighContrast', 'LuciusDarkLowContrast']
    let l:style = l:styles[rand() % len(l:styles)]
    execute l:style
endfunction

function! RandomGruvbox8()
    let g:gruvbox_italics = 0
    let g:gruvbox_italicize_strings = 0
    let backgrounds = ['dark', 'light']
    let &background = backgrounds[rand() % len(backgrounds)]
    let l:styles = ['gruvbox8', 'gruvbox8_hard', 'gruvbox8_soft']
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

" Random colorscheme ------------------------------------------------------{{{1
let s:last_colorscheme_cmd = ''
function! Color#RandomColorScheme()
    if IsInPlugGroup('basic', 'colorscheme')
        let l:styles = [
                    \ 'call Color#RandomVimInbuiltScheme()',
                    \ 'call Color#RandomThirdPartyScheme()',
                    \ ]
    else
        let l:styles = [ 'call Color#RandomVimInbuiltScheme()' ]
    endif
    let l:random_color_scheme_cmd = l:styles[rand() % len(l:styles)]
    execute l:random_color_scheme_cmd
endfunction
