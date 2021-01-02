#! /bin/zsh

# color palette for onedark-palenight custom highlighting
blue=39
cyan=81
green=114
ice=153
orange=173
pink=177
purpink=135
purple=99
red=204
softyellow=223
tblue=26 # terminal default blue
testval=09
yellow=221
pnpurple=104
pnpurpblue=69
pnhighlight=60  # 04 is good too

# zsh-syntax-highlighting custom array
: ${ZSH_HIGHLIGHT_STYLES[arg0]:=fg=$green,bold}
: ${ZSH_HIGHLIGHT_STYLES[assign]:=fg=$purpink,bold}
: ${ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]:=fg=$ice,bold}
: ${ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]:=fg=$ice,bold}
: ${ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]:=fg=$ice,bold}
: ${ZSH_HIGHLIGHT_STYLES[back-quoted-argument]:=fg=$ice,bold}
: ${ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]:=fg=$red,bold}
: ${ZSH_HIGHLIGHT_STYLES[command-substitution]:=fg=$pnpurpblue}
: ${ZSH_HIGHLIGHT_STYLES[commandseparator]:=fg=$ice,bold}
: ${ZSH_HIGHLIGHT_STYLES[comment]:=fg=$ice,bold}
: ${ZSH_HIGHLIGHT_STYLES[default]:=none}
: ${ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]:=fg=bold}
: ${ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]:=fg=bold}
: ${ZSH_HIGHLIGHT_STYLES[double-quoted-argument]:=fg=$green}
: ${ZSH_HIGHLIGHT_STYLES[double-hyphen-option]:=fg=$softyellow,bold}
: ${ZSH_HIGHLIGHT_STYLES[globbing]:=fg=$ice}
: ${ZSH_HIGHLIGHT_STYLES[history-expansion]:=fg=$red,bold}
: ${ZSH_HIGHLIGHT_STYLES[named-fd]:=fg=$testval}
: ${ZSH_HIGHLIGHT_STYLES[path]:=fg=$pnpurple,bold}
: ${ZSH_HIGHLIGHT_STYLES[path_pathseparator]:=}
: ${ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]:=}
: ${ZSH_HIGHLIGHT_STYLES[precommand]:=fg=$orange}
: ${ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]:=fg=$red,bold}
: ${ZSH_HIGHLIGHT_STYLES[process-substitution]:=fg=$pnpurpblue}
: ${ZSH_HIGHLIGHT_STYLES[rc-quote]:=fg=$testval}
: ${ZSH_HIGHLIGHT_STYLES[redirection]:=fg=$ice,bold}
: ${ZSH_HIGHLIGHT_STYLES[reserved-word]:=fg=$softyellow}
: ${ZSH_HIGHLIGHT_STYLES[single-hyphen-option]:=fg=$softyellow,bold}
: ${ZSH_HIGHLIGHT_STYLES[single-quoted-argument]:=fg=$green}
: ${ZSH_HIGHLIGHT_STYLES[suffix-alias]:=fg=$testval}
: ${ZSH_HIGHLIGHT_STYLES[unknown-token]:=}
