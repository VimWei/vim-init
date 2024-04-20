"===================================================
" ColorScheme settings by W.Chen
" Sourced by: ../init.vim
"===================================================

" Default colorscheme ----------------------------------------------------{{{1
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
        \ 'torte', 'wildcharm', 'zaibatsu', 'zellner',
        \ ]
    let l:random_vim_inbuild_scheme = l:styles[rand() % len(l:styles)]
    execute 'colorscheme ' . l:random_vim_inbuild_scheme
endfunction

" Third party colorscheme -------------------------------------------------{{{1
" 通过命令 :color + tab 快速切换常用样式

if IsInPlugGroup('basic', 'colorscheme')
    "随机更换第三方的颜色方案
    command! ColorThirdPartyScheme call RandomThirdPartyScheme()
    function! RandomThirdPartyScheme()
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

    "随机更换 Lucius 的配置方案
    command! ColorLucius call RandomLucius()
    function! RandomLucius()
        let l:styles = ['LuciusLightHighContrast', 'LuciusDarkLowContrast']
        let l:style = l:styles[rand() % len(l:styles)]
        execute l:style
    endfunction

    "随机更换 gruvbox8 的配置方案
    function! RandomGruvbox8()
        let g:gruvbox_italics = 0
        let g:gruvbox_italicize_strings = 0
        let backgrounds = ['dark', 'light']
        let &background = backgrounds[rand() % len(backgrounds)]
        let l:styles = ['gruvbox8', 'gruvbox8_hard', 'gruvbox8_soft']
        execute 'colorscheme ' . l:styles[rand() % len(l:styles)]
    endfunction

    "随机更换 solarized8 的配置方案
    function! RandomSolarized8()
        let g:solarized_italics = 0
        let backgrounds = ['dark', 'light']
        let &background = backgrounds[rand() % len(backgrounds)]
        let l:styles = ['solarized8', 'solarized8_high', 'solarized8_low', 'solarized8_flat']
        execute 'colorscheme ' . l:styles[rand() % len(l:styles)]
    endfunction

    "随机更换 material 的配置方案
    function! RandomMaterial()
        let l:styles = ['default', 'palenight', 'ocean', 'lighter', 'darker']
        let g:material_theme_style = l:styles[rand() % len(l:styles)]
        execute 'colorscheme material'
    endfunction

    "随机更换 PaperColor 的配置方案
    function! RandomPaperColor()
        let backgrounds = ['dark', 'light']
        let &background = backgrounds[rand() % len(backgrounds)]
        execute 'colorscheme PaperColor'
    endfunction

    "随机更换 sonokai 的配置方案
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
    function! RandomNord()
        let g:nord_underline = 1
        let g:nord_italic = 0
        let g:nord_italic_comments = 0
        execute 'colorscheme nord'
    endfunction

    "随机更换 Vim-One 的配置方案
    function! RandomOne()
        let g:one_allow_italics = 0
        let backgrounds = ['dark', 'light']
        let &background = backgrounds[rand() % len(backgrounds)]
        execute 'colorscheme one'
    endfunction
endif

" Random colorscheme ------------------------------------------------------{{{1
" 使用 <leader>c 随机更换颜色方案，每次都不同
nnoremap <silent> <Leader>c :call RandomColorScheme()<CR>:color<CR>
let s:last_colorscheme_cmd = ''
function! RandomColorScheme()
    if IsInPlugGroup('basic', 'colorscheme')
        let l:styles = [ 'ColorVimInbuiltScheme', 'ColorThirdPartyScheme' ]
    else
        let l:styles = [ 'ColorVimInbuiltScheme' ]
    endif
    let l:random_color_scheme_cmd = l:styles[rand() % len(l:styles)]
    execute l:random_color_scheme_cmd
endfunction
