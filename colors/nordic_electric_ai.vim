" nordic_electric_ai.vim - An electric AI-inspired colorscheme with Nordic/Freyja elements
" Author: Lain. a.k.a. Dima, Freyja & Amazon Q
" Created: 2025-03-17

" Reset syntax highlighting
hi clear
if exists("syntax_on")
  syntax reset
endif

" Set colorscheme name
let g:colors_name = "nordic_electric_ai"

" Define colors - electric but easier on the eyes with Nordic influence
let s:bg_dark = "#0f1525"       " Deeper blue-black like Nordic night sky
let s:bg = "#151e33"            " Dark blue with a hint of Nordic twilight
let s:bg_highlight = "#1e2a42"  " Slightly lighter for highlights
let s:terminal_black = "#2d3450"
let s:fg = "#d6e5ff"            " Softer white with blue tint like snow
let s:fg_dark = "#b0c0e0"
let s:fg_gutter = "#3b4261"
let s:dark3 = "#545c7e"
let s:comment = "#607090"       " Softer blue-gray for comments
let s:dark5 = "#737aa2"
let s:blue = "#3b9eff"          " Softer electric blue like fjord waters
let s:cyan = "#20e6d6"          " Softer cyan like glacier ice
let s:purple = "#9966ff"        " Royal purple like Freyja's cloak
let s:green = "#5df0b0"         " Nordic forest green with electric touch
let s:orange = "#ff9e4f"        " Amber like Nordic gold
let s:yellow = "#f5d67f"        " Softer gold like Freyja's tears
let s:red = "#ff5d8f"           " Softer red
let s:teal = "#40d9c4"          " Nordic sea teal
let s:pink = "#e571b5"          " Softer pink like Nordic wildflowers
let s:electric_blue = "#4499ff" " Slightly softer electric blue
let s:rune_gold = "#e6c276"     " Color of ancient runes

" UI elements
exe "hi Normal guifg=".s:fg." guibg=".s:bg
exe "hi LineNr guifg=".s:fg_gutter
exe "hi CursorLine guibg=".s:bg_highlight
exe "hi CursorLineNr guifg=".s:rune_gold
exe "hi SignColumn guibg=".s:bg
exe "hi VertSplit guifg=".s:dark3
exe "hi ColorColumn guibg=".s:bg_highlight
exe "hi Folded guifg=".s:dark5." guibg=".s:bg_highlight
exe "hi FoldColumn guifg=".s:comment." guibg=".s:bg
exe "hi Pmenu guifg=".s:fg." guibg=".s:bg_highlight
exe "hi PmenuSel guifg=".s:bg." guibg=".s:electric_blue
exe "hi PmenuSbar guibg=".s:terminal_black
exe "hi PmenuThumb guibg=".s:dark5
exe "hi StatusLine guifg=".s:fg." guibg=".s:bg_highlight
exe "hi StatusLineNC guifg=".s:dark5." guibg=".s:bg_highlight
exe "hi Search guifg=".s:bg." guibg=".s:yellow
exe "hi IncSearch guifg=".s:bg." guibg=".s:orange
exe "hi Visual guibg=".s:dark3
exe "hi MatchParen guifg=".s:orange." guibg=".s:bg_highlight

" Syntax highlighting
exe "hi Comment guifg=".s:comment
exe "hi Constant guifg=".s:orange
exe "hi String guifg=".s:green
exe "hi Character guifg=".s:green
exe "hi Number guifg=".s:orange
exe "hi Boolean guifg=".s:orange
exe "hi Float guifg=".s:orange
exe "hi Identifier guifg=".s:electric_blue
exe "hi Function guifg=".s:cyan
exe "hi Statement guifg=".s:purple
exe "hi Conditional guifg=".s:purple
exe "hi Repeat guifg=".s:purple
exe "hi Label guifg=".s:purple
exe "hi Operator guifg=".s:pink
exe "hi Keyword guifg=".s:purple
exe "hi Exception guifg=".s:red
exe "hi PreProc guifg=".s:cyan
exe "hi Include guifg=".s:cyan
exe "hi Define guifg=".s:cyan
exe "hi Macro guifg=".s:cyan
exe "hi PreCondit guifg=".s:cyan
exe "hi Type guifg=".s:rune_gold
exe "hi StorageClass guifg=".s:rune_gold
exe "hi Structure guifg=".s:rune_gold
exe "hi Typedef guifg=".s:rune_gold
exe "hi Special guifg=".s:electric_blue
exe "hi SpecialChar guifg=".s:teal
exe "hi Tag guifg=".s:electric_blue
exe "hi Delimiter guifg=".s:fg
exe "hi SpecialComment guifg=".s:dark5
exe "hi Debug guifg=".s:fg
exe "hi Underlined gui=underline"
exe "hi Ignore guifg=".s:fg
exe "hi Error guifg=".s:red." guibg=".s:bg
exe "hi Todo guifg=".s:purple." guibg=".s:bg

" Diff highlighting
exe "hi DiffAdd guifg=".s:green." guibg=".s:bg_highlight
exe "hi DiffChange guifg=".s:blue." guibg=".s:bg_highlight
exe "hi DiffDelete guifg=".s:red." guibg=".s:bg_highlight
exe "hi DiffText guifg=".s:yellow." guibg=".s:bg_highlight

" Links
hi! link NonText Comment
hi! link SpecialKey Comment
hi! link EndOfBuffer Comment
hi! link Directory Identifier
hi! link Question Statement
hi! link Title Statement
hi! link MoreMsg Statement
hi! link WarningMsg Error
hi! link ErrorMsg Error
