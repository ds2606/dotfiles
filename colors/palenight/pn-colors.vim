" vim:fdm=marker
" Vim Color File
" Name:       palenight.vim
" Maintainer: Daniel Schreck
" License:    The MIT License (MIT)
" Based On:   https://github.com/joshdick/onedark.vim


" COLOR REFERENCE

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


" INITIALIZATION

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


function! palenight#set_highlight(group, style)
  call s:h(a:group, a:style)
endfunction

function! palenight#extend_highlight(group, style)
  call s:h(a:group, a:style, 1)
endfunction


" COLOR VARIABLES

let s:colors = palenight#GetColors()

let s:black = s:colors.black
let s:blue = s:colors.blue
let s:cyan = s:colors.cyan
let s:green = s:colors.green
let s:ice = s:colors.ice
let s:orange = s:colors.orange
let s:pink = s:colors.pink_soft
let s:pink_bright = s:colors.pink_bright
let s:purp_blue = s:colors.purp_blue
let s:purp_darker = s:colors.purp_darker
let s:purple = s:colors.purple
let s:red = s:colors.red
let s:red_dark = s:colors.red_dark
let s:white = s:colors.white
let s:yellow = s:colors.yellow
let s:yellow = s:colors.yellow_orange
let s:yellow_soft = s:colors.yellow_soft
let s:z_comment_grey = s:colors.highlight
let s:z_cursor_grey = s:colors.z_cursor_grey
let s:z_gutter_fg_grey = s:colors.z_gutter_fg_grey
let s:z_linenr_grey = s:colors.z_linenr_grey
let s:z_menu_grey = s:colors.z_menu_grey
let s:z_special_grey = s:colors.z_special_grey
let s:z_term_grey = s:colors.z_term_grey
let s:z_test = s:colors.z_test
let s:z_vertsplit = s:colors.z_vertsplit
let s:z_visual_black = s:colors.z_visual_black " Black out selected text in 16-color visual mode
let s:z_visual_grey = s:colors.z_visual_grey

" Terminal Colors {{{
let g:terminal_ansi_colors = [
  \ s:black.gui, s:red.gui, s:green.gui, s:yellow.gui,
  \ s:blue.gui, s:pink.gui, s:cyan.gui, s:white.gui,
  \ s:z_visual_grey.gui, s:red_dark.gui, s:green.gui, s:orange.gui,
  \ s:blue.gui, s:pink.gui, s:cyan.gui, s:z_comment_grey.gui
\]


" SYNTAX GROUPS (descriptions and ordering from `:h w18`)

call s:h("Comment", { "fg": s:z_comment_grey, "gui": "italic", "cterm": "italic" }) " any comment
call s:h("Constant", { "fg": s:cyan })                                              " any constant
call s:h("String", { "fg": s:green }) " a string constant: "this is a string"
call s:h("Character", { "fg": s:green })                                            " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:orange })                                              " a number constant: 234, 0xff
call s:h("Boolean", { "fg": s:orange })                                             " a boolean constant: TRUE, false
call s:h("Float", { "fg": s:orange })                                               " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:red })                                             " any variable name
call s:h("Function", { "fg": s:blue })                                              " function name (also: methods for classes)
call s:h("Statement", { "fg": s:purple })                                             " any statement
call s:h("Conditional", { "fg": s:purple })                                           " if, then, else, endif, switch, etc.
call s:h("Repeat", { "fg": s:purple })                                                " for, do, while, etc.
call s:h("Label", { "fg": s:purple })                                                 " case, default, etc.
call s:h("Operator", { "fg": s:purple }) " sizeof", "+", "*", etc.
call s:h("Keyword", { "fg": s:red })                                                " any other keyword
call s:h("Exception", { "fg": s:purple })                                           " try, catch, throw
call s:h("PreProc", { "fg": s:yellow_soft })                                        " generic Preprocessor
call s:h("Include", { "fg": s:blue })                                               " preprocessor #include
call s:h("Define", { "fg": s:pink })                                                " preprocessor #define
call s:h("Macro", { "fg": s:purple })                                                 " same as Define
call s:h("PreCondit", { "fg": s:yellow_soft })                                      " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:yellow_soft })                                           " int, long, char, etc.
call s:h("StorageClass", { "fg": s:yellow_soft })                                   " static, register, volatile, etc.
call s:h("Structure", { "fg": s:yellow_soft })                                      " struct, union, enum, etc.
call s:h("Typedef", { "fg": s:yellow_soft })                                        " A typedef
call s:h("Special", { "fg": s:blue })                                               " any special symbol
call s:h("SpecialChar", { "fg": s:orange })                                         " special character in a constant
call s:h("Tag", {})                                                                 " you can use CTRL-] on this
call s:h("Delimiter", {})                                                           " character that needs attention
call s:h("SpecialComment", { "fg": s:z_comment_grey })                              " special things inside a comment
call s:h("Debug", {})                                                               " debugging statements
call s:h("Underlined", { "gui": "underline", "cterm": "underline" })                " text that stands out, HTML links
call s:h("Ignore", {})                                                              " left blank, hidden
call s:h("Error", { "fg": s:red })                                                  " any erroneous construct
call s:h("Todo", { "fg": s:pink_bright })                                           " anything that needs extra attention; mostly the keywords TODO FIXME and XXX


" HIGHLIGHTING GROUPS (descriptions and ordering from `:h highlight-groups`)

call s:h("ColorColumn", { "bg": s:z_cursor_grey })                                   " used for the columns set with 'colorcolumn'
call s:h("Conceal", {})                                                              " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor", { "fg": s:black, "bg": s:blue })                                  " the character under the cursor
call s:h("CursorIM", {})                                                             " like Cursor, but used when in IME mode
call s:h("CursorColumn", { "bg": s:z_cursor_grey })                                  " the screen column that the cursor is in when 'cursorcolumn' is set
if &diff
                                                                                     " Don't change the background color in diff mode
  call s:h("CursorLine", { "gui": "underline" })                                     " the screen line that the cursor is in when 'cursorline' is set
else
  call s:h("CursorLine", { "bg": s:z_cursor_grey })                                  " the screen line that the cursor is in when 'cursorline' is set
endif
call s:h("Directory", { "fg": s:blue })                                              " directory names (and other special names in listings)
call s:h("DiffAdd", { "bg": s:green, "fg": s:black })                                " diff mode: Added line
call s:h("DiffChange", { "fg": s:yellow, "gui": "underline", "cterm": "underline" }) " diff mode: Changed line
call s:h("DiffDelete", { "bg": s:red, "fg": s:black })                               " diff mode: Deleted line
call s:h("DiffText", { "bg": s:yellow, "fg": s:black })                              " diff mode: Changed text within a changed line
if get(g:, 'palenight_hide_endofbuffer', 0)                                          " If enabled, will style end-of-buffer filler lines (~) to appear to be hidden.
    call s:h("EndOfBuffer", { "fg": s:black })                                       " filler lines (~) after the last line in the buffer
endif
call s:h("ErrorMsg", { "fg": s:red })                                                " error messages on the command line
call s:h("VertSplit", { "fg": s:z_vertsplit, "bg": s:z_vertsplit })                  " the column separating vertically split windows
call s:h("Folded", { "fg": s:z_comment_grey })                                       " line used for closed folds
call s:h("FoldColumn", {})                                                           " 'foldcolumn'
call s:h("SignColumn", {})                                                           " column where signs are displayed
call s:h("IncSearch", { "fg": s:red, "cterm": "bold", "bg": s:z_test }) " 'incsearch' highlighting; also used for the text replaced with ":s///c"
call s:h("LineNr", { "fg": s:z_linenr_grey }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
call s:h("cursorlinenr", {})                                                         " like linenr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("matchparen", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })   " the character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
call s:h("MoreMsg", {})                                                              " more-prompt
call s:h("NonText", { "fg": s:z_special_grey }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
call s:h("Normal", { "fg": s:white, "bg": s:black })                                 " normal text
call s:h("Pmenu", { "bg": s:z_menu_grey })                                           " Popup menu: normal item.
call s:h("PmenuSel", { "fg": s:z_cursor_grey, "bg": s:purp_blue })                   " Popup menu: selected item.
call s:h("PmenuSbar", { "bg": s:z_special_grey })                                    " Popup menu: scrollbar.
call s:h("PmenuThumb", { "bg": s:white })                                            " Popup menu: Thumb of the scrollbar.
call s:h("Question", { "fg": s:pink })                                               " hit-enter prompt and yes/no questions
call s:h("QuickFixLine", { "fg": s:black, "bg": s:yellow })                          " Current quickfix item in the quickfix window.
call s:h("Search", { "bg": s:z_test })                                               " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
call s:h("SpecialKey", { "fg": s:z_special_grey }) " Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h("SpellBad", { "fg": s:red, "gui": "underline", "cterm": "underline" })      " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap", { "fg": s:orange })                                             " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal", { "fg": s:orange })                                           " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare", { "fg": s:orange })                                            " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h("StatusLine", { "fg": s:white, "bg": s:z_cursor_grey })                     " status line of current window
call s:h("StatusLineNC", { "fg": s:z_comment_grey }) " status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
call s:h("StatusLineTerm", { "fg": s:white, "bg": s:z_cursor_grey })                 " status line of current :terminal window
call s:h("StatusLineTermNC", { "fg": s:z_comment_grey })                             " status line of non-current :terminal window
call s:h("TabLine", { "fg": s:red })                                                 " tab pages line, not active tab page label
call s:h("TabLineFill", {})                                                          " tab pages line, where there are no labels
call s:h("TabLineSel", { "fg": s:white })                                            " tab pages line, active tab page label
call s:h("Terminal", { "fg": s:white, "bg": s:black })                               " terminal window (see terminal-size-color)
call s:h("Title", { "fg": s:green }) " titles for output from ":set all", ":autocmd" etc.
call s:h("Visual", { "fg": s:z_visual_black, "bg": s:z_menu_grey })                  " Visual mode selection
call s:h("VisualNOS", { "bg": s:z_visual_grey }) " Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg", { "fg": s:yellow })                                           " warning messages
call s:h("WildMenu", { "fg": s:purple, "bg": s:z_visual_grey })                      " current match in 'wildmenu' completion

" Termdebug highlighting for Vim 8.1+ 
" (See `:h hl-debugPC` and `:h hl-debugBreakpoint`.)
call s:h("debugPC", { "bg": s:z_special_grey }) " the current position
call s:h("debugBreakpoint", { "fg": s:black, "bg": s:red }) " a breakpoint


" LANGUAGE-SPECIFIC HIGHLIGHTING

" Python
call s:h("pythonBoolean", { "fg": s:red })
call s:h("pythonBuiltin", { "fg": s:green })
call s:h("pythonBuiltinFunc", { "fg": s:blue })
call s:h("pythonBuiltinObj", { "fg": s:yellow })
call s:h("pythonBuiltinType", { "fg": s:yellow })
call s:h("pythonClass", { "fg": s:yellow, "cterm": "bold" })
call s:h("pythonClassVar", { "fg": s:ice })
call s:h("pythonCoding", { "fg": s:z_comment_grey })
call s:h("pythonConditional", { "fg": s:purple })
call s:h("pythonDecorator", { "fg": s:orange })
call s:h("pythonDecoratorName", { "fg": s:orange })
call s:h("pythonDot", { "fg": s:z_comment_grey })
call s:h("pythonDottedName", { "fg": s:orange })
call s:h("pythonExClass", { "fg": s:red })
call s:h("pythonException", { "fg": s:purple })
call s:h("pythonExceptions", { "fg": s:purple })
call s:h("pythonFloat", { "fg": s:orange })
call s:h("pythonFunction", { "fg": s:purp_blue })
call s:h("pythonFunctionCall", { "fg": s:ice })
call s:h("pythonImport", { "fg": s:purple })
call s:h("pythonInclude", { "fg": s:purple })
call s:h("pythonNumber", { "fg": s:orange })
call s:h("pythonNone", { "fg": s:red })
call s:h("pythonOperator", { "fg": s:purple })
call s:h("pythonRepeat", { "fg": s:purple })
call s:h("pythonStatement", { "fg": s:purple })
call s:h("pythonStrFormat", { "fg": s:z_term_grey })
call s:h("pythonStrInterpRegion", { "fg": s:purp_darker })

" Rust
call s:h("rustNumber", { "fg": s:orange })
call s:h("rustStructure", { "fg": s:purple })
call s:h("rustKeyword", { "fg": s:purple })
call s:h("rustFuncCall", { "fg": s:purp_blue })
call s:h("rustFuncName", { "fg": s:purp_blue })
call s:h("rustIdentifier", { "fg": s:ice })
call s:h("rustAttribute", { "fg": s:orange })
call s:h("rustOperator", { "fg": s:purple })
call s:h("rustTypedef", { "fg": s:purple })
call s:h("rustType", { "fg": s:yellow })
call s:h("rustAssert", { "fg": s:orange })

" Java
call s:h("javaAccessKeyword", { "fg": s:blue })


" PLUGIN-SPECIFIC HIGHLIGHTING

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
call s:h("EasyMotionShade",  { "fg": s:z_comment_grey })

" plasticboy/vim-markdown (keep consistent with Markdown, above)
call s:h("mkdDelimiter", { "fg": s:pink })
call s:h("mkdHeading", { "fg": s:red })
call s:h("mkdLink", { "fg": s:blue })
call s:h("mkdURL", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })

" tpope/vim-fugitive
call s:h("diffAdded", { "fg": s:green })
call s:h("diffRemoved", { "fg": s:red })


" GIT HIGHLIGHTING
call s:h("gitcommitComment", { "fg": s:z_comment_grey })
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


" Must appear at the end of the file to work around this oddity:
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
hi Normal ctermbg=NONE
