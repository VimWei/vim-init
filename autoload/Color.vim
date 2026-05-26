" colorscheme

" colorscheme helper -----------------------------------------------------{{{1
" Check if a colorscheme file exists in runtimepath
function! Color#SchemeExists(name)
    return !empty(globpath(&runtimepath, 'colors/' . a:name . '.vim'))
endfunction

" 根据 colorscheme 名构建命令：有对应 Random* 函数则 call，否则直接 color
function! Color#SchemeCommand(scheme_name)
    let l:func_name = 'Random' . toupper(a:scheme_name[0]) . a:scheme_name[1:]
    if exists('*' . l:func_name)
        return 'call ' . l:func_name . '()'
    endif
    return 'color ' . a:scheme_name
endfunction

" 根据时段返回 background：06:00-21:00 随机，其他时段固定 dark
function! Color#RandomBackground()
    if date#time#IsTimeInRange('06:00', '21:00')
        return ['dark', 'light'][rand() % 2]
    endif
    return 'dark'
endfunction

" Vim inbuilt colorscheme ------------------------------------------------{{{1
function! Color#RandomVimInbuiltScheme()
    let l:styles = map(
        \ globpath($VIMRUNTIME, 'colors/*.vim', 0, 1),
        \ 'fnamemodify(v:val, ":t:r")'
        \ )
    if empty(l:styles)
        return
    endif
    let l:commands = map(l:styles, 'Color#SchemeCommand(v:val)')
    let l:random_scheme_cmd = l:commands[rand() % len(l:commands)]
    execute l:random_scheme_cmd
endfunction

function! RandomQuiet()
    let &background = Color#RandomBackground()
    execute 'colorscheme quiet'
endfunction

function! RandomRetrobox()
    let &background = 'dark'
    execute 'colorscheme retrobox'
endfunction

" VimInit colorscheme ----------------------------------------------------{{{1
function! Color#RandomVimInitScheme()
    let l:schemes = map(
        \ globpath(g:viminit, 'colors/*.vim', 0, 1),
        \ 'fnamemodify(v:val, ":t:r")'
        \ )
    if empty(l:schemes)
        return
    endif
    let l:styles = map(l:schemes, 'Color#SchemeCommand(v:val)')
    let l:random_scheme_cmd = l:styles[rand() % len(l:styles)]
    execute l:random_scheme_cmd
endfunction

function! RandomLucius()
    let l:styles = ['LuciusLightHighContrast', 'LuciusDarkLowContrast']
    if !date#time#IsTimeInRange('06:00', '21:00')
        let l:styles = ['LuciusDarkLowContrast']
    endif
    let l:style_cmd = l:styles[rand() % len(l:styles)]
    execute 'color lucius'
    execute l:style_cmd
endfunction

" Third party colorscheme ------------------------------------------------{{{1
function! Color#RandomThirdPartyScheme()
    let l:all = globpath(&rtp, 'colors/*.vim', 0, 1)
    let l:builtin = globpath($VIMRUNTIME, 'colors/*.vim', 0, 1)
    let l:viminit_colors = globpath(g:viminit, 'colors/*.vim', 0, 1)
    let l:third_party = filter(copy(l:all), 'index(l:builtin, v:val) < 0 && index(l:viminit_colors, v:val) < 0')
    if empty(l:third_party)
        return
    endif
    let l:schemes = map(l:third_party, 'fnamemodify(v:val, ":t:r")')
    let l:styles = map(l:schemes, 'Color#SchemeCommand(v:val)')
    let l:random_scheme_cmd = l:styles[rand() % len(l:styles)]
    execute l:random_scheme_cmd
endfunction

function! RandomXcode()
    let l:styles = ['xcode', 'xcodehc']
    let &background = Color#RandomBackground()
    execute 'colorscheme ' . l:styles[rand() % len(l:styles)]
endfunction

function! RandomGruvbox8()
    let g:gruvbox_italics = 0
    let g:gruvbox_italicize_strings = 0
    let l:styles = ['gruvbox8', 'gruvbox8_soft']
    let &background = Color#RandomBackground()
    execute 'colorscheme ' . l:styles[rand() % len(l:styles)]
endfunction

function! RandomSolarized8()
    let g:solarized_italics = 0
    let l:styles = ['solarized8', 'solarized8_high', 'solarized8_low', 'solarized8_flat']
    let &background = Color#RandomBackground()
    execute 'colorscheme ' . l:styles[rand() % len(l:styles)]
endfunction

function! RandomMaterial()
    let l:styles = ['default', 'palenight', 'ocean', 'lighter', 'darker']
    let g:material_theme_style = l:styles[rand() % len(l:styles)]
    execute 'colorscheme material'
endfunction

function! RandomPaperColor()
    let &background = Color#RandomBackground()
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
    " let backgrounds = ['dark', 'light']
    let backgrounds = ['dark']
    let &background = backgrounds[rand() % len(backgrounds)]
    execute 'colorscheme one'
endfunction

function! RandomAfterglow()
    let g:afterglow_use_italics=0
    let g:afterglow_blackout=1
    execute 'colorscheme afterglow'
endfunction

function! RandomIceberg()
    let &background = Color#RandomBackground()
    execute 'colorscheme iceberg'
endfunction

" Favorite colorscheme ---------------------------------------------------{{{1
function! Color#RandomFavoriteScheme(...)
    " 配置 favorite colorschemes
    let l:favorites = [
            \ 'gaea', 'delek', 'eclipse',
            \ 'borland256', 'murphy',
            \ 'quack', 'codedark',
            \ 'wildcharm', 'nordic_electric_ai',
            \ 'quiet', 'lucius', 'afterglow',
            \ 'gruvbox8', 'one', 'iceberg',
            \ 'retrobox',
            \ ]
    " 过滤掉当前环境中不存在的 colorscheme
    let l:favorites = filter(l:favorites, 'Color#SchemeExists(v:val)')

    " 默认行为：采用随机的colorscheme
    let l:styles = map(copy(l:favorites), 'Color#SchemeCommand(v:val)')
    if empty(l:styles)
        return
    endif
    let l:colorscheme_cmd = l:styles[rand() % len(l:styles)]

    " 若指定了有效的 colorscheme，则采用该 colorscheme
    if a:0 > 0 && !empty(a:1)
        if !empty(globpath(&runtimepath, 'colors/' . a:1 . '.vim'))
            let l:colorscheme_cmd = Color#SchemeCommand(a:1)
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
