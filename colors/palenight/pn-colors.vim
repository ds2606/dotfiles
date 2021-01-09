" vim:fdm=marker
" Vim Color File
" Name:       onedark.vim
" Maintainer: https://github.com/joshdick/onedark.vim/
" License:    The MIT License (MIT)
" Based On:   https://github.com/MaxSt/FlatColor/

" A companion [vim-airline](https://github.com/bling/vim-airline) theme is available at: https://github.com/joshdick/airline-onedark.vim

" Color Reference {{{

" The following colors were measured inside Atom using its built-in inspector.

" +---------------------------------------------+
" |  Color Name  |         RGB        |   Hex   |
" |--------------+--------------------+---------|
" | Black        | rgb(40, 44, 52)    | #282c34 |
" |--------------+--------------------+---------|
" | White        | rgb(171, 178, 191) | #abb2bf |
" |--------------+--------------------+---------|
" | Light Red    | rgb(224, 108, 117) | #e06c75 |
" |--------------+--------------------+---------|
" | Dark Red     | rgb(190, 80, 70)   | #be5046 |
" |--------------+--------------------+---------|
" | Green        | rgb(152, 195, 121) | #98c379 |
" |--------------+--------------------+---------|
" | Light Yellow | rgb(229, 192, 123) | #e5c07b |
" |--------------+--------------------+---------|
" | Dark Yellow  | rgb(209, 154, 102) | #d19a66 |
" |--------------+--------------------+---------|
" | Blue         | rgb(97, 175, 239)  | #61afef |
" |--------------+--------------------+---------|
" | Magenta      | rgb(198, 120, 221) | #c678dd |
" |--------------+--------------------+---------|
" | Cyan         | rgb(86, 182, 194)  | #56b6c2 |
" |--------------+--------------------+---------|
" | Gutter Grey  | rgb(76, 82, 99)    | #4b5263 |
" |--------------+--------------------+---------|
" | Comment Grey | rgb(92, 99, 112)   | #5c6370 |
" +---------------------------------------------+

" }}}

" Initialization {{{

highlight clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

let g:colors_name="palenight"

" Set to "256" for 256-color terminals, or
" set to "16" to use your terminal emulator's native colors
" (a 16-color palette for this color scheme is available; see
" < https://github.com/joshdick/onedark.vim/blob/master/README.md >
" for more information.)
if !exists("g:palenight_termcolors")
  let g:palenight_termcolors = 256
endif

" Not all terminals support italics properly. If yours does, opt-in.
if !exists("g:palenight_terminal_italics")
  let g:palenight_terminal_italics = 0
endif

" This function is based on one from FlatColor: https://github.com/MaxSt/FlatColor/
" Which in turn was based on one found in hemisu: https://github.com/noahfrederick/vim-hemisu/
let s:group_colors = {} " Cache of default highlight group settings, for later reference via `onedark#extend_highlight`
function! s:h(group, style, ...)
  if (a:0 > 0) " Will be true if we got here from palenight#extend_highlight
    let s:highlight = s:group_colors[a:group]
    for style_type in ["fg", "bg", "sp"]
      if (has_key(a:style, style_type))
        let l:default_style = (has_key(s:highlight, style_type) ? s:highlight[style_type] : { "cterm16": "NONE", "cterm": "NONE", "gui": "NONE" })
        let s:highlight[style_type] = extend(l:default_style, a:style[style_type])
      endif
    endfor
    if (has_key(a:style, "gui"))
      let s:highlight.gui = a:style.gui
    endif
  else
    let s:highlight = a:style
    let s:group_colors[a:group] = s:highlight " Cache default highlight group settings
  endif

  if g:palenight_terminal_italics == 0
    if has_key(s:highlight, "cterm") && s:highlight["cterm"] == "italic"
      unlet s:highlight.cterm
    endif
    if has_key(s:highlight, "gui") && s:highlight["gui"] == "italic"
      unlet s:highlight.gui
    endif
  endif

  if g:palenight_termcolors == 16
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm : "NONE")
  endif

  execute "highlight" a:group
    \ "guifg="   (has_key(s:highlight, "fg")    ? s:highlight.fg.gui   : "NONE")
    \ "guibg="   (has_key(s:highlight, "bg")    ? s:highlight.bg.gui   : "NONE")
    \ "guisp="   (has_key(s:highlight, "sp")    ? s:highlight.sp.gui   : "NONE")
    \ "gui="     (has_key(s:highlight, "gui")   ? s:highlight.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(s:highlight, "cterm") ? s:highlight.cterm    : "NONE")
endfunction

" public {{{

function! palenight#set_highlight(group, style)
  call s:h(a:group, a:style)
endfunction

function! palenight#extend_highlight(group, style)
  call s:h(a:group, a:style, 1)
endfunction

" }}}

" }}}

" Color Variables {{{

let s:colors = palenight#GetColors()

let s:pn_pink = s:colors.pn_pink
let s:pn_purple = s:colors.pn_purple
let s:pn_purpblue = s:colors.pn_purpblue
let s:pn_purpdarker = s:colors.pn_purpdarker
let s:ice = s:colors.ice
let s:pnyellow = s:colors.pnyellow
let s:softyellow = s:colors.softyellow
let s:pn_highlight = s:colors.pn_highlight
let s:red = s:colors.red
let s:dark_red = s:colors.dark_red
let s:green = s:colors.green
let s:yellow = s:colors.yellow
let s:orange = s:colors.orange
let s:blue = s:colors.blue
let s:pink = s:colors.pink
let s:cyan = s:colors.cyan
let s:white = s:colors.white
let s:black = s:colors.black
let s:visual_black = s:colors.visual_black " Black out selected text in 16-color visual mode
let s:comment_grey = s:colors.pn_highlight
let s:gutter_fg_grey = s:colors.gutter_fg_grey
let s:cursor_grey = s:colors.cursor_grey
let s:visual_grey = s:colors.visual_grey
let s:menu_grey = s:colors.menu_grey
let s:special_grey = s:colors.special_grey
let s:vertsplit = s:colors.vertsplit
let s:test = s:colors.test
let s:term_grey = s:colors.term_grey

" }}}

" Terminal Colors {{{

let g:terminal_ansi_colors = [
  \ s:black.gui, s:red.gui, s:green.gui, s:yellow.gui,
  \ s:blue.gui, s:pink.gui, s:cyan.gui, s:white.gui,
  \ s:visual_grey.gui, s:dark_red.gui, s:green.gui, s:orange.gui,
  \ s:blue.gui, s:pink.gui, s:cyan.gui, s:comment_grey.gui
\]

" }}}

" Syntax Groups (descriptions and ordering from `:h w18`) {{{

call s:h("Comment", { "fg": s:comment_grey, "gui": "italic", "cterm": "italic" }) " any comment
call s:h("Constant", { "fg": s:cyan }) " any constant
call s:h("String", { "fg": s:green }) " a string constant: "this is a string"
call s:h("Character", { "fg": s:green }) " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:orange }) " a number constant: 234, 0xff
call s:h("Boolean", { "fg": s:orange }) " a boolean constant: TRUE, false
call s:h("Float", { "fg": s:orange }) " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:red }) " any variable name
call s:h("Function", { "fg": s:blue }) " function name (also: methods for classes)
call s:h("Statement", { "fg": s:pink }) " any statement
call s:h("Conditional", { "fg": s:pink }) " if, then, else, endif, switch, etc.
call s:h("Repeat", { "fg": s:pink }) " for, do, while, etc.
call s:h("Label", { "fg": s:pink }) " case, default, etc.
call s:h("Operator", { "fg": s:pink }) " sizeof", "+", "*", etc.
call s:h("Keyword", { "fg": s:red }) " any other keyword
call s:h("Exception", { "fg": s:pink }) " try, catch, throw
call s:h("PreProc", { "fg": s:softyellow }) " generic Preprocessor
call s:h("Include", { "fg": s:blue }) " preprocessor #include
call s:h("Define", { "fg": s:pink }) " preprocessor #define
call s:h("Macro", { "fg": s:pink }) " same as Define
call s:h("PreCondit", { "fg": s:softyellow }) " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:softyellow }) " int, long, char, etc.
call s:h("StorageClass", { "fg": s:softyellow }) " static, register, volatile, etc.
call s:h("Structure", { "fg": s:softyellow }) " struct, union, enum, etc.
call s:h("Typedef", { "fg": s:softyellow }) " A typedef
call s:h("Special", { "fg": s:blue }) " any special symbol
call s:h("SpecialChar", { "fg": s:orange }) " special character in a constant
call s:h("Tag", {}) " you can use CTRL-] on this
call s:h("Delimiter", {}) " character that needs attention
call s:h("SpecialComment", { "fg": s:comment_grey }) " special things inside a comment
call s:h("Debug", {}) " debugging statements
call s:h("Underlined", { "gui": "underline", "cterm": "underline" }) " text that stands out, HTML links
call s:h("Ignore", {}) " left blank, hidden
call s:h("Error", { "fg": s:red }) " any erroneous construct
call s:h("Todo", { "fg": s:pink }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX

" }}}

" Highlighting Groups (descriptions and ordering from `:h highlight-groups`) {{{
call s:h("ColorColumn", { "bg": s:cursor_grey }) " used for the columns set with 'colorcolumn'
call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor", { "fg": s:black, "bg": s:blue }) " the character under the cursor
call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
call s:h("CursorColumn", { "bg": s:cursor_grey }) " the screen column that the cursor is in when 'cursorcolumn' is set
if &diff
  " Don't change the background color in diff mode
  call s:h("CursorLine", { "gui": "underline" }) " the screen line that the cursor is in when 'cursorline' is set
else
  call s:h("CursorLine", { "bg": s:cursor_grey }) " the screen line that the cursor is in when 'cursorline' is set
endif
call s:h("Directory", { "fg": s:blue }) " directory names (and other special names in listings)
call s:h("DiffAdd", { "bg": s:green, "fg": s:black }) " diff mode: Added line
call s:h("DiffChange", { "fg": s:yellow, "gui": "underline", "cterm": "underline" }) " diff mode: Changed line
call s:h("DiffDelete", { "bg": s:red, "fg": s:black }) " diff mode: Deleted line
call s:h("DiffText", { "bg": s:yellow, "fg": s:black }) " diff mode: Changed text within a changed line
if get(g:, 'palenight_hide_endofbuffer', 0)
    " If enabled, will style end-of-buffer filler lines (~) to appear to be hidden.
    call s:h("EndOfBuffer", { "fg": s:black }) " filler lines (~) after the last line in the buffer
endif
call s:h("ErrorMsg", { "fg": s:red }) " error messages on the command line
call s:h("VertSplit", { "fg": s:vertsplit }) " the column separating vertically split windows
call s:h("Folded", { "fg": s:comment_grey }) " line used for closed folds
call s:h("FoldColumn", {}) " 'foldcolumn'
call s:h("SignColumn", {}) " column where signs are displayed
call s:h("IncSearch", { "fg": s:red, "cterm": "bold", "bg": s:test }) " 'incsearch' highlighting; also used for the text replaced with ":s///c"
call s:h("LineNr", { "fg": s:gutter_fg_grey }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
call s:h("CursorLineNr", {}) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("MatchParen", { "fg": s:cyan, "gui": "underline", "cterm": "underline" }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
call s:h("MoreMsg", {}) " more-prompt
call s:h("NonText", { "fg": s:special_grey }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
call s:h("Normal", { "fg": s:white, "bg": s:black }) " normal text
call s:h("Pmenu", { "bg": s:menu_grey }) " Popup menu: normal item.
call s:h("PmenuSel", { "fg": s:pn_highlight, "bg": s:pn_purpblue }) " Popup menu: selected item.
call s:h("PmenuSbar", { "bg": s:special_grey }) " Popup menu: scrollbar.
call s:h("PmenuThumb", { "bg": s:white }) " Popup menu: Thumb of the scrollbar.
call s:h("Question", { "fg": s:pink }) " hit-enter prompt and yes/no questions
call s:h("QuickFixLine", { "fg": s:black, "bg": s:yellow }) " Current quickfix item in the quickfix window.
call s:h("Search", { "bg": s:test }) " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
call s:h("SpecialKey", { "fg": s:special_grey }) " Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h("SpellBad", { "fg": s:red, "gui": "underline", "cterm": "underline" }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap", { "fg": s:orange }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal", { "fg": s:orange }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare", { "fg": s:orange }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h("StatusLine", { "fg": s:white, "bg": s:cursor_grey }) " status line of current window
call s:h("StatusLineNC", { "fg": s:comment_grey }) " status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
call s:h("StatusLineTerm", { "fg": s:white, "bg": s:cursor_grey }) " status line of current :terminal window
call s:h("StatusLineTermNC", { "fg": s:comment_grey }) " status line of non-current :terminal window
call s:h("TabLine", { "fg": s:red }) " tab pages line, not active tab page label
call s:h("TabLineFill", {}) " tab pages line, where there are no labels
call s:h("TabLineSel", { "fg": s:white }) " tab pages line, active tab page label
call s:h("Terminal", { "fg": s:white, "bg": s:black }) " terminal window (see terminal-size-color)
call s:h("Title", { "fg": s:green }) " titles for output from ":set all", ":autocmd" etc.
call s:h("Visual", { "fg": s:visual_black, "bg": s:menu_grey }) " Visual mode selection
call s:h("VisualNOS", { "bg": s:visual_grey }) " Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg", { "fg": s:yellow }) " warning messages
call s:h("WildMenu", { "fg": s:pn_purple, "bg": s:visual_grey }) " current match in 'wildmenu' completion

" }}}

" Termdebug highlighting for Vim 8.1+ {{{

" See `:h hl-debugPC` and `:h hl-debugBreakpoint`.
call s:h("debugPC", { "bg": s:special_grey }) " the current position
call s:h("debugBreakpoint", { "fg": s:black, "bg": s:red }) " a breakpoint

" }}}

" Language-Specific Highlighting {{{

" python-syntax: https://github.com/vim-python/python-syntax{{{
call s:h("pythonBoolean", { "fg": s:red })
call s:h("pythonBuiltin", { "fg": s:green })
call s:h("pythonBuiltinFunc", { "fg": s:blue })
call s:h("pythonBuiltinObj", { "fg": s:pnyellow })
call s:h("pythonBuiltinType", { "fg": s:pnyellow })
call s:h("pythonClass", { "fg": s:yellow, "cterm": "bold" })
call s:h("pythonClassVar", { "fg": s:ice })
call s:h("pythonCoding", { "fg": s:comment_grey })
call s:h("pythonConditional", { "fg": s:pink })
call s:h("pythonDecorator", { "fg": s:orange })
call s:h("pythonDecoratorName", { "fg": s:orange })
call s:h("pythonDot", { "fg": s:comment_grey })
call s:h("pythonDottedName", { "fg": s:orange })
call s:h("pythonExClass", { "fg": s:red })
call s:h("pythonException", { "fg": s:pink })
call s:h("pythonExceptions", { "fg": s:pink })
call s:h("pythonFloat", { "fg": s:orange })
call s:h("pythonFunction", { "fg": s:pn_purpblue })
call s:h("pythonFunctionCall", { "fg": s:ice })
call s:h("pythonImport", { "fg": s:pink })
call s:h("pythonInclude", { "fg": s:pink })
call s:h("pythonNumber", { "fg": s:orange })
call s:h("pythonNone", { "fg": s:red })
call s:h("pythonOperator", { "fg": s:pn_pink })
call s:h("pythonRepeat", { "fg": s:pink })
call s:h("pythonStatement", { "fg": s:pink })
call s:h("pythonStrFormat", { "fg": s:term_grey })
call s:h("pythonStrInterpRegion", { "fg": s:pn_purpdarker })

" CSS
" call s:h("cssAttrComma", { "fg": s:pink })
" call s:h("cssAttributeSelector", { "fg": s:green })
" call s:h("cssBraces", { "fg": s:white })
" call s:h("cssClassName", { "fg": s:orange })
" call s:h("cssClassNameDot", { "fg": s:orange })
" call s:h("cssDefinition", { "fg": s:pink })
" call s:h("cssFontAttr", { "fg": s:orange })
" call s:h("cssFontDescriptor", { "fg": s:pink })
" call s:h("cssFunctionName", { "fg": s:blue })
" call s:h("cssIdentifier", { "fg": s:blue })
" call s:h("cssImportant", { "fg": s:pink })
" call s:h("cssInclude", { "fg": s:white })
" call s:h("cssIncludeKeyword", { "fg": s:pink })
" call s:h("cssMediaType", { "fg": s:orange })
" call s:h("cssProp", { "fg": s:white })
" call s:h("cssPseudoClassId", { "fg": s:orange })
" call s:h("cssSelectorOp", { "fg": s:pink })
" call s:h("cssSelectorOp2", { "fg": s:pink })
" call s:h("cssTagName", { "fg": s:red })

" Fish Shell
" call s:h("fishKeyword", { "fg": s:pink })
" call s:h("fishConditional", { "fg": s:pink })

" Go
" call s:h("goDeclaration", { "fg": s:pink })
" call s:h("goBuiltins", { "fg": s:cyan })
" call s:h("goFunctionCall", { "fg": s:blue })
" call s:h("goVarDefs", { "fg": s:red })
" call s:h("goVarAssign", { "fg": s:red })
" call s:h("goVar", { "fg": s:pink })
" call s:h("goConst", { "fg": s:pink })
" call s:h("goType", { "fg": s:yellow })
" call s:h("goTypeName", { "fg": s:yellow })
" call s:h("goDeclType", { "fg": s:cyan })
" call s:h("goTypeDecl", { "fg": s:pink })

" HTML (keep consistent with Markdown, below)
" call s:h("htmlArg", { "fg": s:orange })
" call s:h("htmlBold", { "fg": s:orange, "gui": "bold", "cterm": "bold" })
" call s:h("htmlEndTag", { "fg": s:white })
" call s:h("htmlH1", { "fg": s:red })
" call s:h("htmlH2", { "fg": s:red })
" call s:h("htmlH3", { "fg": s:red })
" call s:h("htmlH4", { "fg": s:red })
" call s:h("htmlH5", { "fg": s:red })
" call s:h("htmlH6", { "fg": s:red })
" call s:h("htmlItalic", { "fg": s:pink, "gui": "italic", "cterm": "italic" })
" call s:h("htmlLink", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })
" call s:h("htmlSpecialChar", { "fg": s:orange })
" call s:h("htmlSpecialTagName", { "fg": s:red })
" call s:h("htmlTag", { "fg": s:white })
" call s:h("htmlTagN", { "fg": s:red })
" call s:h("htmlTagName", { "fg": s:red })
" call s:h("htmlTitle", { "fg": s:white })

" JavaScript
" call s:h("javaScriptBraces", { "fg": s:white })
" call s:h("javaScriptFunction", { "fg": s:pink })
" call s:h("javaScriptIdentifier", { "fg": s:pink })
" call s:h("javaScriptNull", { "fg": s:orange })
" call s:h("javaScriptNumber", { "fg": s:orange })
" call s:h("javaScriptRequire", { "fg": s:cyan })
" call s:h("javaScriptReserved", { "fg": s:pink })
" " https://github.com/pangloss/vim-javascript
" call s:h("jsArrowFunction", { "fg": s:pink })
" call s:h("jsClassKeyword", { "fg": s:pink })
" call s:h("jsClassMethodType", { "fg": s:pink })
" call s:h("jsDocParam", { "fg": s:blue })
" call s:h("jsDocTags", { "fg": s:pink })
" call s:h("jsExport", { "fg": s:pink })
" call s:h("jsExportDefault", { "fg": s:pink })
" call s:h("jsExtendsKeyword", { "fg": s:pink })
" call s:h("jsFrom", { "fg": s:pink })
" call s:h("jsFuncCall", { "fg": s:blue })
" call s:h("jsFunction", { "fg": s:pink })
" call s:h("jsGenerator", { "fg": s:yellow })
" call s:h("jsGlobalObjects", { "fg": s:yellow })
" call s:h("jsImport", { "fg": s:pink })
" call s:h("jsModuleAs", { "fg": s:pink })
" call s:h("jsModuleWords", { "fg": s:pink })
" call s:h("jsModules", { "fg": s:pink })
" call s:h("jsNull", { "fg": s:orange })
" call s:h("jsOperator", { "fg": s:pink })
" call s:h("jsStorageClass", { "fg": s:pink })
" call s:h("jsSuper", { "fg": s:red })
" call s:h("jsTemplateBraces", { "fg": s:dark_red })
" call s:h("jsTemplateVar", { "fg": s:green })
" call s:h("jsThis", { "fg": s:red })
" call s:h("jsUndefined", { "fg": s:orange })
" " https://github.com/othree/yajs.vim
" call s:h("javascriptArrowFunc", { "fg": s:pink })
" call s:h("javascriptClassExtends", { "fg": s:pink })
" call s:h("javascriptClassKeyword", { "fg": s:pink })
" call s:h("javascriptDocNotation", { "fg": s:pink })
" call s:h("javascriptDocParamName", { "fg": s:blue })
" call s:h("javascriptDocTags", { "fg": s:pink })
" call s:h("javascriptEndColons", { "fg": s:white })
" call s:h("javascriptExport", { "fg": s:pink })
" call s:h("javascriptFuncArg", { "fg": s:white })
" call s:h("javascriptFuncKeyword", { "fg": s:pink })
" call s:h("javascriptIdentifier", { "fg": s:red })
" call s:h("javascriptImport", { "fg": s:pink })
" call s:h("javascriptMethodName", { "fg": s:white })
" call s:h("javascriptObjectLabel", { "fg": s:white })
" call s:h("javascriptOpSymbol", { "fg": s:cyan })
" call s:h("javascriptOpSymbols", { "fg": s:cyan })
" call s:h("javascriptPropertyName", { "fg": s:green })
" call s:h("javascriptTemplateSB", { "fg": s:dark_red })
" call s:h("javascriptVariable", { "fg": s:pink })

" JSON
" call s:h("jsonCommentError", { "fg": s:white })
" call s:h("jsonKeyword", { "fg": s:red })
" call s:h("jsonBoolean", { "fg": s:orange })
" call s:h("jsonNumber", { "fg": s:orange })
" call s:h("jsonQuote", { "fg": s:white })
" call s:h("jsonMissingCommaError", { "fg": s:red, "gui": "reverse" })
" call s:h("jsonNoQuotesError", { "fg": s:red, "gui": "reverse" })
" call s:h("jsonNumError", { "fg": s:red, "gui": "reverse" })
" call s:h("jsonString", { "fg": s:green })
" call s:h("jsonStringSQError", { "fg": s:red, "gui": "reverse" })
" call s:h("jsonSemicolonError", { "fg": s:red, "gui": "reverse" })

" LESS
" call s:h("lessVariable", { "fg": s:pink })
" call s:h("lessAmpersandChar", { "fg": s:white })
" call s:h("lessClass", { "fg": s:orange })

" Markdown (keep consistent with HTML, above)
" call s:h("markdownBlockquote", { "fg": s:comment_grey })
" call s:h("markdownBold", { "fg": s:orange, "gui": "bold", "cterm": "bold" })
" call s:h("markdownCode", { "fg": s:green })
" call s:h("markdownCodeBlock", { "fg": s:green })
" call s:h("markdownCodeDelimiter", { "fg": s:green })
" call s:h("markdownH1", { "fg": s:red })
" call s:h("markdownH2", { "fg": s:red })
" call s:h("markdownH3", { "fg": s:red })
" call s:h("markdownH4", { "fg": s:red })
" call s:h("markdownH5", { "fg": s:red })
" call s:h("markdownH6", { "fg": s:red })
" call s:h("markdownHeadingDelimiter", { "fg": s:red })
" call s:h("markdownHeadingRule", { "fg": s:comment_grey })
" call s:h("markdownId", { "fg": s:pink })
" call s:h("markdownIdDeclaration", { "fg": s:blue })
" call s:h("markdownIdDelimiter", { "fg": s:pink })
" call s:h("markdownItalic", { "fg": s:pink, "gui": "italic", "cterm": "italic" })
" call s:h("markdownLinkDelimiter", { "fg": s:pink })
" call s:h("markdownLinkText", { "fg": s:blue })
" call s:h("markdownListMarker", { "fg": s:red })
" call s:h("markdownOrderedListMarker", { "fg": s:red })
" call s:h("markdownRule", { "fg": s:comment_grey })
" call s:h("markdownUrl", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })

" Perl
" call s:h("perlFiledescRead", { "fg": s:green })
" call s:h("perlFunction", { "fg": s:pink })
" call s:h("perlMatchStartEnd",{ "fg": s:blue })
" call s:h("perlMethod", { "fg": s:pink })
" call s:h("perlPOD", { "fg": s:comment_grey })
" call s:h("perlSharpBang", { "fg": s:comment_grey })
" call s:h("perlSpecialString",{ "fg": s:orange })
" call s:h("perlStatementFiledesc", { "fg": s:red })
" call s:h("perlStatementFlow",{ "fg": s:red })
" call s:h("perlStatementInclude", { "fg": s:pink })
" call s:h("perlStatementScalar",{ "fg": s:pink })
" call s:h("perlStatementStorage", { "fg": s:pink })
" call s:h("perlSubName",{ "fg": s:yellow })
" call s:h("perlVarPlain",{ "fg": s:blue })

" PHP
" call s:h("phpVarSelector", { "fg": s:red })
" call s:h("phpOperator", { "fg": s:white })
" call s:h("phpParent", { "fg": s:white })
" call s:h("phpMemberSelector", { "fg": s:white })
" call s:h("phpType", { "fg": s:pink })
" call s:h("phpKeyword", { "fg": s:pink })
" call s:h("phpClass", { "fg": s:yellow })
" call s:h("phpUseClass", { "fg": s:white })
" call s:h("phpUseAlias", { "fg": s:white })
" call s:h("phpInclude", { "fg": s:pink })
" call s:h("phpClassExtends", { "fg": s:green })
" call s:h("phpDocTags", { "fg": s:white })
" call s:h("phpFunction", { "fg": s:blue })
" call s:h("phpFunctions", { "fg": s:cyan })
" call s:h("phpMethodsVar", { "fg": s:orange })
" call s:h("phpMagicConstants", { "fg": s:orange })
" call s:h("phpSuperglobals", { "fg": s:red })
" call s:h("phpConstants", { "fg": s:orange })

" Ruby
" call s:h("rubyBlockParameter", { "fg": s:red})
" call s:h("rubyBlockParameterList", { "fg": s:red })
" call s:h("rubyClass", { "fg": s:pink})
" call s:h("rubyConstant", { "fg": s:yellow})
" call s:h("rubyControl", { "fg": s:pink })
" call s:h("rubyEscape", { "fg": s:red})
" call s:h("rubyFunction", { "fg": s:blue})
" call s:h("rubyGlobalVariable", { "fg": s:red})
" call s:h("rubyInclude", { "fg": s:blue})
" call s:h("rubyIncluderubyGlobalVariable", { "fg": s:red})
" call s:h("rubyInstanceVariable", { "fg": s:red})
" call s:h("rubyInterpolation", { "fg": s:cyan })
" call s:h("rubyInterpolationDelimiter", { "fg": s:red })
" call s:h("rubyInterpolationDelimiter", { "fg": s:red})
" call s:h("rubyRegexp", { "fg": s:cyan})
" call s:h("rubyRegexpDelimiter", { "fg": s:cyan})
" call s:h("rubyStringDelimiter", { "fg": s:green})
" call s:h("rubySymbol", { "fg": s:cyan})

" Sass
" https://github.com/tpope/vim-haml
" call s:h("sassAmpersand", { "fg": s:red })
" call s:h("sassClass", { "fg": s:orange })
" call s:h("sassControl", { "fg": s:pink })
" call s:h("sassExtend", { "fg": s:pink })
" call s:h("sassFor", { "fg": s:white })
" call s:h("sassFunction", { "fg": s:cyan })
" call s:h("sassId", { "fg": s:blue })
" call s:h("sassInclude", { "fg": s:pink })
" call s:h("sassMedia", { "fg": s:pink })
" call s:h("sassMediaOperators", { "fg": s:white })
" call s:h("sassMixin", { "fg": s:pink })
" call s:h("sassMixinName", { "fg": s:blue })
" call s:h("sassMixing", { "fg": s:pink })
" call s:h("sassVariable", { "fg": s:pink })
" " https://github.com/cakebaker/scss-syntax.vim
" call s:h("scssExtend", { "fg": s:pink })
" call s:h("scssImport", { "fg": s:pink })
" call s:h("scssInclude", { "fg": s:pink })
" call s:h("scssMixin", { "fg": s:pink })
" call s:h("scssSelectorName", { "fg": s:orange })
" call s:h("scssVariable", { "fg": s:pink })

" TeX
call s:h("texStatement", { "fg": s:blue })
call s:h("texSubscripts", { "fg": s:orange })
call s:h("texSuperscripts", { "fg": s:orange })
call s:h("texTodo", { "fg": s:green })
call s:h("texBeginEnd", { "fg": s:pink })
call s:h("texBeginEndName", { "fg": s:pn_purpblue })
call s:h("texMathMatcher", { "fg": s:pink })
call s:h("texMathZoneX", { "fg": s:orange })
call s:h("texMathDelim", { "fg": s:red })
call s:h("texDelimiter", { "fg": s:orange })
call s:h("texSpecialChar", { "fg": s:orange })
call s:h("texCite", { "fg": s:blue })
call s:h("texRefZone", { "fg": s:blue })
call s:h("TexCommentTodo", { "fg": s:green })

" TypeScript
" call s:h("typescriptReserved", { "fg": s:pink })
" call s:h("typescriptEndColons", { "fg": s:white })
" call s:h("typescriptBraces", { "fg": s:white })

" XML
" call s:h("xmlAttrib", { "fg": s:orange })
" call s:h("xmlEndTag", { "fg": s:red })
" call s:h("xmlTag", { "fg": s:red })
" call s:h("xmlTagName", { "fg": s:red })

" }}}

" Plugin Highlighting {{{

" airblade/vim-gitgutter
hi link GitGutterAdd    SignifySignAdd
hi link GitGutterChange SignifySignChange
hi link GitGutterDelete SignifySignDelete

" dense-analysis/ale
call s:h("ALEError", { "fg": s:red, "gui": "underline", "cterm": "underline" })
call s:h("ALEWarning", { "fg": s:yellow, "gui": "underline", "cterm": "underline"})
call s:h("ALEInfo", { "gui": "underline", "cterm": "underline"})

" easymotion/vim-easymotion
call s:h("EasyMotionTarget", { "fg": s:red, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2First", { "fg": s:yellow, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2Second", { "fg": s:orange, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionShade",  { "fg": s:comment_grey })

" mhinz/vim-signify
call s:h("SignifySignAdd", { "fg": s:green })
call s:h("SignifySignChange", { "fg": s:yellow })
call s:h("SignifySignDelete", { "fg": s:red })

" plasticboy/vim-markdown (keep consistent with Markdown, above)
call s:h("mkdDelimiter", { "fg": s:pink })
call s:h("mkdHeading", { "fg": s:red })
call s:h("mkdLink", { "fg": s:blue })
call s:h("mkdURL", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })

" tpope/vim-fugitive
call s:h("diffAdded", { "fg": s:green })
call s:h("diffRemoved", { "fg": s:red })

" }}}

" Git Highlighting {{{

call s:h("gitcommitComment", { "fg": s:comment_grey })
call s:h("gitcommitUnmerged", { "fg": s:green })
call s:h("gitcommitOnBranch", {})
call s:h("gitcommitBranch", { "fg": s:pink })
call s:h("gitcommitDiscardedType", { "fg": s:red })
call s:h("gitcommitSelectedType", { "fg": s:green })
call s:h("gitcommitHeader", {})
call s:h("gitcommitUntrackedFile", { "fg": s:cyan })
call s:h("gitcommitDiscardedFile", { "fg": s:red })
call s:h("gitcommitSelectedFile", { "fg": s:green })
call s:h("gitcommitUnmergedFile", { "fg": s:yellow })
call s:h("gitcommitFile", {})
call s:h("gitcommitSummary", { "fg": s:white })
call s:h("gitcommitOverflow", { "fg": s:red })
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile

" }}}


" Must appear at the end of the file to work around this oddity:
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
hi Normal ctermbg=NONE
