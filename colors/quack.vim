" Name:			quack
" Author:		charan
" Mail:			charancuz008gmail.com

set background=dark
hi clear
let g:colors_name = 'quack'

let s:t_Co = has('gui_running') ? 16777216 : str2nr(&t_Co)
let s:tgc = has('termguicolors') && &termguicolors

hi! link Boolean Constant
hi! link Character Constant
hi! link Conditional Statement
hi! link CursorLineFold SignColumn
hi! link CursorLineSign SignColumn
hi! link Debug Special
hi! link Define PreProc
hi! link EndOfBuffer NonText
hi! link Exception Statement
hi! link Float Constant
hi! link FoldColumn SignColumn
hi! link Function Identifier
hi! link Ignore Normal
hi! link IncSearch CurSearch
hi! link Include PreProc
hi! link Keyword Statement
hi! link Label Statement
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link Macro PreProc
hi! link MessageWindow PMenu
hi! link Number Constant
hi! link PmenuExtra Pmenu
hi! link PmenuExtraSel PmenuSel
hi! link PmenuKind Pmenu
hi! link PmenuKindSel PmenuSel
hi! link PmenuSbar Pmenu
hi! link PopupNotification Todo
hi! link PreCondit PreProc
hi! link PreInsert NonText
hi! link Repeat Statement
hi! link SpecialChar Special
hi! link SpecialComment Special
hi! link StatusLineTerm Statusline
hi! link StatusLineTermNC StatuslineNC
hi! link StorageClass Type
hi! link Structure Type
hi! link TabLine StatusLineNC
hi! link TabLineFill StatusLineNC
hi! link TabPanel Normal
hi! link TabPanelFill Normal
hi! link Tag Special
hi! link Terminal Normal
hi! link Typedef Type
hi! link VertSplit Normal
hi! link VisualNOS Visual
hi! link WildMenu PmenuSel
hi! link colortemplateKey Statement
hi! link csAccessModifier Statement
hi! link csAsyncModifier Statement
hi! link csClass Statement
hi! link csClassType Normal
hi! link csLogicSymbols Normal
hi! link csModifier Statement
hi! link csStorage Statement
hi! link csType Statement
hi! link diffFile PreProc
hi! link fugitiveHash Constant
hi! link fugitiveHeading Statement
hi! link fugitiveStagedHeading Statement
hi! link fugitiveStagedModifier PreProc
hi! link fugitiveSymbolicRef PreProc
hi! link fugitiveUnstagedHeading Statement
hi! link fugitiveUnstagedModifier PreProc
hi! link fugitiveUntrackedHeading Statement
hi! link helpHeader Title
hi! link helpHyperTextJump Underlined
hi! link helpVim Title
hi! link javaClassDecl Statement
hi! link javaDocParam PreProc
hi! link javaExternal Statement
hi! link javaScopeDecl Statement
hi! link javaScriptFunction Statement
hi! link javaScriptIdentifier Statement
hi! link javaStorageClass Statement
hi! link javaType Statement
hi! link markdownHeadingDelimiter Special
hi! link markdownUrl String
hi! link phpComparison Normal
hi! link phpDefine Statement
hi! link phpDocCustomTags phpDocTags
hi! link phpInclude Statement
hi! link phpMemberSelector Special
hi! link phpOperator Normal
hi! link phpParent Normal
hi! link phpSpecialFunction Normal
hi! link phpStorageClass Statement
hi! link phpStructure Statement
hi! link phpVarSelector Special
hi! link pythonInclude Statement
hi! link rstCodeBlock Normal
hi! link rstDelimiter Special
hi! link rstDirective PreProc
hi! link rstFieldName Constant
hi! link rstHyperlinkReference Special
hi! link rstInterpretedText Special
hi! link rstLiteralBlock rstCodeBlock
hi! link rstSectionDelimiter Statement
hi! link rubyDefine Statement
hi! link rubyMacro Statement
hi! link shCommandSub Normal
hi! link shDerefOp Special
hi! link shDerefPattern shQuote
hi! link shNoQuote Normal
hi! link shOperator Normal
hi! link shOption Normal
hi! link shQuote Constant
hi! link shSetOption Normal
hi! link shTestOpr Normal
hi! link sqlKeyword Statement
hi! link vimCommentString Comment
hi! link vimGroup Normal
hi! link vimOper Normal
hi! link vimOption Normal
hi! link vimParenSep Normal
hi! link vimSep Normal
hi! link vimVar Normal
hi! link xmlTagName Statement
hi! link yamlBlockMappingKey Statement

"nvim color definitions
" let s:NvimDarkBlue = '#004c73' "
" let s:NvimDarkCyan = '#007373'
" let s:NvimDarkGreen = '#005523'
" let s:NvimDarkGrey1 = '#07080d'
" let s:NvimDarkGrey2 = '#14161b'
" let s:NvimDarkGrey3 = '#2c2e33'
" let s:NvimDarkGrey4 = '#4f5258'
" let s:NvimDarkMagenta = '#470045'
" let s:NvimDarkRed = '#590008'
" let s:NvimDarkYellow = '#6b5300'
" let s:NvimLightBlue = '#a6dbff'
" let s:NvimLightCyan = '#8cf8f7'
" let s:NvimLightGreen = '#b3f6c0' "
" let s:NvimLightGrey1 = '#eef1f8'
" let s:NvimLightGrey2 = '#e0e2ea'
" let s:NvimLightGrey3 = '#c4c6cd'
" let s:NvimLightGrey4 = '#9b9ea4'
" let s:NvimLightMagenta = '#ffcaff'
" let s:NvimLightRed = '#ffc0b9'
" let s:NvimLightYellow = '#fce094'

if &background == 'dark'
	let g:terminal_ansi_colors = ['#000000', '#af5f5f', '#5faf5f', '#af875f', '#5f87af', '#d787d7', '#5fafaf', '#c6c6c6', '#767676', '#ff5f5f', '#5fd75f', '#ffd787', '#5fafff', '#ff87ff', '#5fd7d7', '#ffffff']

	hi Added gui=NONE term=NONE cterm=NONE guifg=#b3f6c0 guibg=NONE ctermfg=157 ctermbg=NONE
	hi EndOfBuffer guifg=#4f5258 guibg=NONE guisp=NONE gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE term=NONE
	hi IncSearch guifg=#eef1f8 guibg=#fce094 guisp=NONE gui=NONE ctermfg=0 ctermbg=11 cterm=NONE term=bold,reverse,underline
	hi ToolbarButton guifg=#000000 guibg=#ffffff guisp=NONE gui=NONE ctermfg=16 ctermbg=231 cterm=NONE term=bold,reverse
	hi ToolbarLine guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE term=reverse
	hi WinBar           guifg=#9b9ea4 guibg=#07080d gui=bold cterm=bold
	hi WinBarNC         guifg=#9b9ea4 guibg=#07080d
	hi debugBreakpoint guifg=#5fafaf guibg=NONE guisp=NONE gui=reverse ctermfg=73 ctermbg=NONE cterm=reverse term=reverse
	hi debugPC guifg=#5f87af guibg=NONE guisp=NONE gui=reverse ctermfg=67 ctermbg=NONE cterm=reverse term=reverse
	hi dirGroup guifg=#767676 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE term=NONE
	hi dirOwner guifg=#767676 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE term=NONE
	hi dirPermissionGroup guifg=#af875f guibg=NONE guisp=NONE gui=NONE ctermfg=137 ctermbg=NONE cterm=NONE term=NONE
	hi dirPermissionOther guifg=#5fafaf guibg=NONE guisp=NONE gui=NONE ctermfg=73 ctermbg=NONE cterm=NONE term=NONE
	hi dirPermissionUser guifg=#5faf5f guibg=NONE guisp=NONE gui=NONE ctermfg=71 ctermbg=NONE cterm=NONE term=NONE
	hi dirSize guifg=#ffd787 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE term=NONE
	hi dirSizeMod guifg=#d787d7 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE term=NONE
	hi dirTime guifg=#767676 guibg=NONE guisp=NONE gui=NONE ctermfg=243 ctermbg=NONE cterm=NONE term=NONE
	hi dirType guifg=#d787d7 guibg=NONE guisp=NONE gui=NONE ctermfg=176 ctermbg=NONE cterm=NONE term=NONE
	hi Changed gui=NONE term=NONE cterm=NONE guifg=#8cf8f7 guibg=NONE ctermfg=123 ctermbg=NONE
	hi ColorColumn gui=NONE term=reverse,inverse cterm=NONE guifg=NONE guibg=#4f5258 ctermfg=NONE ctermbg=239
	hi ColorColumn gui=NONE term=reverse,inverse cterm=NONE guifg=NONE guibg=#4f5258 ctermfg=NONE ctermbg=239
	hi Conceal gui=NONE term=NONE cterm=NONE guifg=#4f5258 guibg=NONE ctermfg=239 ctermbg=NONE
	hi Constant gui=NONE term=NONE cterm=NONE guifg=#e0e2ea guibg=NONE ctermfg=254 ctermbg=NONE
	hi CurSearch gui=NONE term=NONE cterm=NONE guifg=#07080d guibg=#fce094 ctermfg=232 ctermbg=222
	hi Cursor gui=NONE term=NONE cterm=NONE guifg=#14161b guibg=#e0e2ea ctermfg=233 ctermbg=254
	hi CursorColumn gui=NONE term=NONE cterm=NONE guifg=NONE guibg=#2c2e33 ctermfg=NONE ctermbg=236
	hi CursorLine gui=NONE term=NONE cterm=NONE guifg=NONE guibg=#2c2e33 ctermfg=NONE ctermbg=236
	hi CursorLineNr gui=bold term=bold cterm=bold guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE
	hi Delimiter gui=NONE term=NONE cterm=NONE guifg=#e0e2ea guibg=NONE ctermfg=254 ctermbg=NONE
	hi DiffAdd gui=NONE term=NONE cterm=NONE guifg=#eef1f8 guibg=#005523 ctermfg=255 ctermbg=22
	hi DiffChange gui=NONE term=NONE cterm=NONE guifg=#eef1f8 guibg=#4f5258 ctermfg=255 ctermbg=239
	hi DiffDelete gui=bold term=bold cterm=bold guifg=#ffc0b9 guibg=NONE ctermfg=217 ctermbg=NONE
	hi DiffText gui=NONE term=NONE cterm=NONE guifg=#eef1f8 guibg=#007373 ctermfg=255 ctermbg=6
	hi Directory gui=NONE term=NONE cterm=NONE guifg=#8cf8f7 guibg=NONE ctermfg=123 ctermbg=NONE
	hi Error gui=NONE term=NONE cterm=NONE guifg=#eef1f8 guibg=#590008 ctermfg=255 ctermbg=52
	hi ErrorMsg gui=NONE term=NONE cterm=NONE guifg=#ffc0b9 guibg=NONE ctermfg=217 ctermbg=NONE
	hi Folded gui=NONE term=NONE cterm=NONE guifg=#9b9ea4 guibg=#07080d ctermfg=247 ctermbg=232
	hi Function gui=NONE term=NONE cterm=NONE guifg=#8cf8f7 guibg=NONE ctermfg=123 ctermbg=NONE
	hi Identifier gui=NONE term=NONE cterm=NONE guifg=#a6dbff guibg=NONE ctermfg=153 ctermbg=NONE
	hi LineNr gui=NONE term=NONE cterm=NONE guifg=#4f5258 guibg=NONE ctermfg=239 ctermbg=NONE
	hi MatchParen gui=bold term=underline,bold cterm=bold guifg=NONE guibg=#4f5258 ctermfg=NONE ctermbg=239
	hi ModeMsg gui=NONE term=NONE cterm=NONE guifg=#b3f6c0 guibg=NONE ctermfg=157 ctermbg=NONE
	hi MoreMsg gui=NONE term=NONE cterm=NONE guifg=#8cf8f7 guibg=NONE ctermfg=123 ctermbg=NONE
	hi NonText gui=NONE term=NONE cterm=NONE guifg=#4f5258 guibg=NONE ctermfg=239 ctermbg=NONE
	hi Normal gui=NONE term=NONE cterm=NONE guifg=#e0e2ea guibg=#14161b ctermfg=254 ctermbg=233
	hi Operator gui=NONE term=NONE cterm=NONE guifg=#e0e2ea guibg=NONE ctermfg=254 ctermbg=NONE
	hi Pmenu gui=NONE term=reverse,inverse cterm=NONE guifg=NONE guibg=#2c2e33 ctermfg=NONE ctermbg=236
	hi PmenuMatch gui=bold term=bold cterm=bold guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE
	hi PmenuMatchSel gui=bold term=bold cterm=bold guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE
	hi PmenuSel gui=reverse,inverse term=underline,reverse,inverse cterm=reverse,inverse guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE
	hi PmenuThumb gui=NONE term=NONE cterm=NONE guifg=NONE guibg=#4f5258 ctermfg=NONE ctermbg=239
	hi PreProc gui=NONE term=NONE cterm=NONE guifg=#e0e2ea guibg=NONE ctermfg=254 ctermbg=NONE
	hi Question gui=NONE term=NONE cterm=NONE guifg=#8cf8f7 guibg=NONE ctermfg=123 ctermbg=NONE
	hi QuickFixLine gui=NONE term=NONE cterm=NONE guifg=#8cf8f7 guibg=NONE ctermfg=123 ctermbg=NONE
	hi Removed gui=NONE term=NONE cterm=NONE guifg=#ffc0b9 guibg=NONE ctermfg=217 ctermbg=NONE
	hi Search gui=NONE term=NONE cterm=NONE guifg=#eef1f8 guibg=#6b5300 ctermfg=255 ctermbg=58
	hi SignColumn gui=NONE term=NONE cterm=NONE guifg=#4f5258 guibg=NONE ctermfg=239 ctermbg=NONE
	hi Special gui=NONE term=NONE cterm=NONE guifg=#8cf8f7 guibg=NONE ctermfg=123 ctermbg=NONE
	hi SpecialKey gui=NONE term=NONE cterm=NONE guifg=#4f5258 guibg=NONE ctermfg=239 ctermbg=NONE
	hi SpellBad gui=undercurl term=undercurl cterm=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE guisp=#ffc0b9
	hi SpellCap gui=undercurl term=undercurl cterm=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE guisp=#fce094
	hi SpellLocal gui=undercurl term=undercurl cterm=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE guisp=#b3f6c0
	hi SpellRare gui=undercurl term=undercurl cterm=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE guisp=#8cf8f7
	hi Statement gui=bold term=bold cterm=bold guifg=#e0e2ea guibg=NONE ctermfg=254 ctermbg=NONE
	hi StatusLine gui=NONE term=reverse,inverse cterm=NONE guifg=#2c2e33 guibg=#c4c6cd ctermfg=236 ctermbg=251
	hi StatusLineNC gui=NONE term=underline,bold cterm=NONE guifg=#e0e2ea guibg=#4f5258 ctermfg=254 ctermbg=239
	hi String gui=NONE term=NONE cterm=NONE guifg=#b3f6c0 guibg=NONE ctermfg=157 ctermbg=NONE
	hi TabLineSel gui=bold term=NONE cterm=bold guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE
	hi Title gui=bold term=bold cterm=bold guifg=#e0e2ea guibg=NONE ctermfg=254 ctermbg=NONE
	hi Todo gui=bold term=bold cterm=bold guifg=#e0e2ea guibg=NONE ctermfg=254 ctermbg=NONE
	hi Type gui=NONE term=NONE cterm=NONE guifg=#e0e2ea guibg=NONE ctermfg=254 ctermbg=NONE
	hi Underlined gui=underline term=underline cterm=underline guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE
	hi Visual gui=NONE term=NONE cterm=NONE guifg=NONE guibg=#4f5258 ctermfg=NONE ctermbg=239
	hi WarningMsg gui=NONE term=NONE cterm=NONE guifg=#fce094 guibg=NONE ctermfg=222 ctermbg=NONE
	hi lCursor gui=NONE term=NONE cterm=NONE guifg=#14161b guibg=#e0e2ea ctermfg=233 ctermbg=254

	if s:tgc || s:t_Co >= 256
		if s:tgc
			hi IncSearch cterm=NONE
			hi QuickFixLine cterm=NONE
			hi Search cterm=NONE
			hi Visual cterm=NONE
		endif
		finish
	endif

	finish
endif
