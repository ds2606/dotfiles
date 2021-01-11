" [palenight.vim](https://github.com/joshdick/onedark.vim/)

let s:overrides = get(g:, "palenight_color_overrides", {})

let s:colors = {
    \ "pnyellow": get(s:overrides, "pnyellow", { "gui": "#FAC056", "cterm": "214", "cterm16": "1" }),
    \ "pn_highlight": get(s:overrides, "pn_highlight", { "gui": "#FAC056", "cterm": "104", "cterm16": "1" }),
    \ "pn_purpdarker": get(s:overrides, "pn_purpdarker", { "gui": "#FAC056", "cterm": "63", "cterm16": "1" }),
    \ "pn_pink": get(s:overrides, "pn_pink", { "gui": "#D18DF0", "cterm": "219", "cterm16": "1" }),
    \ "pn_purple": get(s:overrides, "pn_purple", { "gui": "#D18DF0", "cterm": "147", "cterm16": "1" }),
    \ "ice": get(s:overrides, "ice", { "gui": "#A3C5FF", "cterm": "153", "cterm16": "1" }),
    \ "pink": get(s:overrides, "pink", { "gui": "#C678DD", "cterm": "213", "cterm16": "5" }),
    \ "pn_grey": get(s:overrides, "pn_grey", { "gui": "#BEC7D6", "cterm": "152", "cterm16": "1" }),
    \ "pn_purpblue": get(s:overrides, "pn_purpblue", { "gui": "#5f87ff", "cterm": "111", "cterm16": "1" }),
    \ "red": get(s:overrides, "red", { "gui": "#E06C75", "cterm": "211", "cterm16": "1" }),
    \ "dark_red": get(s:overrides, "dark_red", { "gui": "#BE5046", "cterm": "196", "cterm16": "9" }),
    \ "green": get(s:overrides, "green", { "gui": "#98C379", "cterm": "114", "cterm16": "2" }),
    \ "yellow": get(s:overrides, "yellow", { "gui": "#E5C07B", "cterm": "221", "cterm16": "3" }),
    \ "softyellow": get(s:overrides, "softyellow", { "gui": "#E5C07B", "cterm": "223", "cterm16": "3" }),
    \ "orange": get(s:overrides, "orange", { "gui": "#D19A66", "cterm": "209", "cterm16": "11" }),
    \ "blue": get(s:overrides, "blue", { "gui": "#61AFEF", "cterm": "81", "cterm16": "4" }),
    \ "purple": get(s:overrides, "purple", { "gui": "#C678DD", "cterm": "213", "cterm16": "5" }),
    \ "cyan": get(s:overrides, "cyan", { "gui": "#56B6C2", "cterm": "14", "cterm16": "6" }),
    \ "white": get(s:overrides, "white", { "gui": "#ABB2BF", "cterm": "252", "cterm16": "7" }),
    \ "black": get(s:overrides, "black", { "gui": "#282C34", "cterm": "235", "cterm16": "0" }),
    \ "visual_black": get(s:overrides, "visual_black", { "gui": "NONE", "cterm": "NONE", "cterm16": "0" }),
    \ "comment_grey": get(s:overrides, "comment_grey", { "gui": "#5C6370", "cterm": "102", "cterm16": "15" }),
    \ "gutter_fg_grey": get(s:overrides, "gutter_fg_grey", { "gui": "#4B5263", "cterm": "238", "cterm16": "15" }),
    \ "cursor_grey": get(s:overrides, "cursor_grey", { "gui": "#2C323C", "cterm": "236", "cterm16": "8" }),
    \ "visual_grey": get(s:overrides, "visual_grey", { "gui": "#3E4452", "cterm": "237", "cterm16": "15" }),
    \ "menu_grey": get(s:overrides, "menu_grey", { "gui": "#3E4452", "cterm": "238", "cterm16": "8" }),
    \ "special_grey": get(s:overrides, "special_grey", { "gui": "#3B4048", "cterm": "61", "cterm16": "15" }),
    \ "vertsplit": get(s:overrides, "vertsplit", { "gui": "#181A1F", "cterm": "235", "cterm16": "15" }),
    \ "test": get(s:overrides, "test", { "gui": "#181A1F", "cterm": "237", "cterm16": "15" }),
    \ "term_grey": get(s:overrides, "term_grey", { "gui": "#181A1F", "cterm": "249", "cterm16": "15" }),
    \ "warning_orange": get(s:overrides, "warning_orange", { "gui": "#FF8663", "cterm": "202",      "cterm16": "1" }),
    \}

function! palenight#GetColors()
  return s:colors
endfunction
