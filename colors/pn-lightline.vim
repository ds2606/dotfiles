" [palenight.vim](https://github.com/joshdick/palenight.vim/)

" This is a [lightline.vim](https://github.com/itchyny/lightline.vim) colorscheme for use with
" the [palenight.vim](https://github.com/joshdick/palenight.vim) colorscheme.

let s:colors = palenight#GetColors()

if get(g:, 'palenight_termcolors', 256) == 16
  let s:term_black = s:colors.black.cterm16
  let s:term_blue = s:colors.blue.cterm16
  let s:term_green = s:colors.green.cterm16
  let s:term_grey = s:colors.cursor_grey.cterm16
  let s:term_purple = s:colors.purple.cterm16
  let s:term_red = s:colors.red.cterm16
  let s:term_white = s:colors.white.cterm16
  let s:term_yellow = s:colors.yellow.cterm16
else
  let s:term_black = s:colors.black.cterm
  let s:term_blue = s:colors.blue.cterm
  let s:term_green = s:colors.green.cterm
  let s:term_grey = s:colors.cursor_grey.cterm
  let s:term_purple = s:colors.purple.cterm
  let s:term_red = s:colors.red.cterm
  let s:term_white = s:colors.white.cterm
  let s:term_yellow = s:colors.yellow.cterm
endif

let s:black = [ s:colors.black.gui, s:term_black ]
let s:blue   = [ '#61afef', 75 ]
let s:green = [ s:colors.green.gui, s:term_green ]
let s:grey = [ s:colors.visual_grey.gui, s:term_grey ]
let s:purple = [ s:colors.purple.gui, s:term_purple ]
let s:pnhighlight = [ '#5f5f87', 60 ]
let s:red = [ '#ff87af', 211 ]
let s:t = [ '#ff87af', 103 ]
let s:white = [ s:colors.white.gui, s:term_white ]
let s:yellow = [ s:colors.yellow.gui, s:term_yellow ]
let s:darkyellow = [ '#d7875f', 173 ]
let s:okgreen = [ '#005f00', 65 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:black, s:green ], [ s:pnhighlight, s:black ] ]
let s:p.normal.right = [ [ s:black, s:green ], [ s:pnhighlight, s:black ] ]
let s:p.inactive.left =  [ [ s:pnhighlight, s:black ], [ s:pnhighlight, s:black ] ]
let s:p.inactive.right = [ [ s:pnhighlight, s:black ], [ s:pnhighlight, s:black ] ]
let s:p.insert.left = [ [ s:black, s:blue ], [ s:pnhighlight, s:black ] ]
let s:p.insert.right = [ [ s:black, s:blue ], [ s:pnhighlight, s:black ] ]
let s:p.replace.left = [ [ s:black, s:red ], [ s:pnhighlight, s:black ] ]
let s:p.replace.right = [ [ s:black, s:red ], [ s:pnhighlight, s:black ] ]
let s:p.visual.left = [ [ s:black, s:red ], [ s:pnhighlight, s:black ] ]
let s:p.visual.right = [ [ s:black, s:red ], [ s:pnhighlight, s:black ] ]
let s:p.normal.middle = [ [ s:pnhighlight, s:black ] ]
let s:p.inactive.middle = [ [ s:pnhighlight, s:black ] ]
let s:p.tabline.left = [ [ s:pnhighlight, s:grey ] ]
let s:p.tabline.tabsel = [ [ s:grey, s:t ] ]
let s:p.tabline.middle = [ [ s:blue, s:black ] ]
let s:p.tabline.right = [ [ s:pnhighlight, s:grey ] ]
let s:p.normal.error = [ [ s:red, s:grey ] ]
let s:p.normal.warning = [ [ s:darkyellow, s:grey ] ]
let s:p.normal.ok = [ [ s:okgreen, s:grey ] ]

let g:lightline#colorscheme#palenight#palette = lightline#colorscheme#flatten(s:p)

