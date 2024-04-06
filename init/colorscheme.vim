"===================================================
" ColorScheme settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Default colorscheme ------------------------------------------------------{{{1

if has('termguicolors')
    set termguicolors
endif

colorscheme lucius
exe (strftime('%H') % 18) >= 6 ? 'LuciusLightHighContrast' : 'LuciusDarkLowContrast'

" Vim inbuilt colorscheme -------------------------------------------------{{{1

"随机更换 vim 自带的颜色方案
command! ColorVimInbuiltScheme call RandomVimInbuiltScheme()
function! RandomVimInbuiltScheme()
    let l:styles = [
        \ 'blue', 'darkblue', 'default', 'delek', 'desert',
        \ 'elflord', 'evening', 'habamax', 'industry', 'koehler',
        \ 'lunaperche', 'morning', 'murphy', 'pablo', 'peachpuff',
        \ 'quiet', 'retrobox', 'ron', 'shine', 'slate', 'sorbet',
        \ 'torte', 'wildcharm', 'zaibatsu', 'zellner'
        \ ]
    let l:random_vim_inbuild_scheme = l:styles[rand() % len(l:styles)]
    execute 'colorscheme ' . l:random_vim_inbuild_scheme
endfunction

" Third party colorscheme -------------------------------------------------{{{1

if index(g:plug_group['basic'], 'colorscheme') >= 0

    "随机更换第三方的颜色方案
    command! ColorThirdPartyScheme call RandomThirdPartyScheme()
    function! RandomThirdPartyScheme()
        let l:styles = [
            \ 'ColorLucius',
            \ 'ColorGruvbox8',
            \ 'ColorSolarized8',
            \ 'ColorMaterial',
            \ 'ColorPaperColor',
            \ 'ColorSonokai',
            \ 'ColorNord',
            \ 'ColorOne',
            \ 'color landscape',
            \ 'color gotham',
            \ ]
        let l:random_third_party_scheme_cmd = l:styles[rand() % len(l:styles)]
        execute l:random_third_party_scheme_cmd
    endfunction

    "随机更换 Lucius 的配置方案
    command! ColorLucius call RandomLucius()
    function! RandomLucius()
        let l:styles = ['light', 'dark']
        let l:style = l:styles[rand() % len(l:styles)]
        let l:contrasts = ['normal', 'low', 'hight']
        let l:contrast = l:contrasts[rand() % len(l:contrasts)]
        let l:contrast_bgs = ['normal', 'hight']
        let l:contrast_bg = l:contrast_bgs[rand() % len(l:contrast_bgs)]
        call SetLucius(l:style, l:contrast, l:contrast_bg)
        execute 'colorscheme lucius'
    endfunction

    "随机更换 gruvbox8 的配置方案
    command! ColorGruvbox8 call RandomGruvbox8()
    function! RandomGruvbox8()
        let g:gruvbox_italics = 0
        let g:gruvbox_italicize_strings = 0
        let backgrounds = ['dark', 'light']
        let &background = backgrounds[rand() % len(backgrounds)]
        let l:styles = ['gruvbox8', 'gruvbox8_hard', 'gruvbox8_soft']
        execute 'colorscheme ' . l:styles[rand() % len(l:styles)]
    endfunction

    "随机更换 solarized8 的配置方案
    command! ColorSolarized8 call RandomSolarized8()
    function! RandomSolarized8()
        let g:solarized_italics = 0
        let backgrounds = ['dark', 'light']
        let &background = backgrounds[rand() % len(backgrounds)]
        let l:styles = ['solarized8', 'solarized8_high', 'solarized8_low', 'solarized8_flat']
        execute 'colorscheme ' . l:styles[rand() % len(l:styles)]
    endfunction

    "随机更换 material 的配置方案
    command! ColorMaterial call RandomMaterial()
    function! RandomMaterial()
        let l:styles = ['default', 'palenight', 'ocean', 'lighter', 'darker']
        let g:material_theme_style = l:styles[rand() % len(l:styles)]
        execute 'colorscheme material'
    endfunction

    "随机更换 PaperColor 的配置方案
    command! ColorPaperColor call RandomPaperColor()
    function! RandomPaperColor()
        let backgrounds = ['dark', 'light']
        let &background = backgrounds[rand() % len(backgrounds)]
        execute 'colorscheme PaperColor'
    endfunction

    "随机更换 sonokai 的配置方案
    command! ColorSonokai call RandomSonokai()
    function! RandomSonokai()
        let g:sonokai_enable_italic = 0
        let g:sonokai_disable_italic_comment = 1
        let g:sonokai_lightline_disable_bold = 0
        let g:sonokai_better_performance = 1
        let l:styles = ['default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso']
        let g:sonokai_style = l:styles[rand() % len(l:styles)]
        execute 'colorscheme sonokai'
    endfunction

    "随机更换 nord 的配置方案
    command! ColorNord call RandomNord()
    function! RandomNord()
        let g:nord_underline = 1
        let g:nord_italic = 0
        let g:nord_italic_comments = 0
        execute 'colorscheme nord'
    endfunction

    "随机更换 Vim-One 的配置方案
    command! ColorOne call RandomOne()
    function! RandomOne()
        let g:one_allow_italics = 0
        let backgrounds = ['dark', 'light']
        let &background = backgrounds[rand() % len(backgrounds)]
        execute 'colorscheme one'
    endfunction

endif

" Random colorscheme ------------------------------------------------------{{{1

" 通过命令 color + tab 快速切换常用样式

" 使用 <leader>c 随机更换颜色方案，每次都不同
noremap <silent> <leader>c :call RandomColorScheme()<cr>:color<cr>
let s:last_colorscheme_cmd = ''
function! RandomColorScheme()
    if index(g:plug_group['basic'], 'colorscheme') >= 0
        let l:styles = [ 'ColorVimInbuiltScheme', 'ColorThirdPartyScheme' ]
    else
        let l:styles = [ 'ColorVimInbuiltScheme' ]
    endif
    let l:random_color_scheme_cmd = l:styles[rand() % len(l:styles)]
    execute l:random_color_scheme_cmd
endfunction
