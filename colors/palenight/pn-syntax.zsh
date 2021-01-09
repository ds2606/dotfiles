#! /bin/zsh

# get palette colors
source $HOME/.dotfiles/colors/palenight/pn-palette.zsh && pn_colors 256

# zsh-syntax-highlighting custom array
: ${ZSH_HIGHLIGHT_STYLES[arg0]:=fg=$c[green],bold}
: ${ZSH_HIGHLIGHT_STYLES[assign]:=fg=$c[purpink],bold}
: ${ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]:=fg=$c[ice],bold}
: ${ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]:=fg=$c[ice],bold}
: ${ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]:=fg=$c[ice],bold}
: ${ZSH_HIGHLIGHT_STYLES[back-quoted-argument]:=fg=$c[ice],bold}
: ${ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]:=fg=$c[red],bold}
: ${ZSH_HIGHLIGHT_STYLES[command-substitution]:=fg=$c[pnpurpblue]}
: ${ZSH_HIGHLIGHT_STYLES[commandseparator]:=fg=$c[ice],bold}
: ${ZSH_HIGHLIGHT_STYLES[comment]:=fg=$c[ice],bold}
: ${ZSH_HIGHLIGHT_STYLES[default]:=none}
: ${ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]:=fg=bold}
: ${ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]:=fg=bold}
: ${ZSH_HIGHLIGHT_STYLES[double-quoted-argument]:=fg=$c[green]}
: ${ZSH_HIGHLIGHT_STYLES[double-hyphen-option]:=fg=$c[softyellow],bold}
: ${ZSH_HIGHLIGHT_STYLES[globbing]:=fg=$c[ice]}
: ${ZSH_HIGHLIGHT_STYLES[history-expansion]:=fg=$c[red],bold}
: ${ZSH_HIGHLIGHT_STYLES[named-fd]:=fg=$c[testval]}
: ${ZSH_HIGHLIGHT_STYLES[path]:=fg=$c[pnpurple],bold}
: ${ZSH_HIGHLIGHT_STYLES[path_pathseparator]:=}
: ${ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]:=}
: ${ZSH_HIGHLIGHT_STYLES[precommand]:=fg=$c[orange]}
: ${ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]:=fg=$c[red],bold}
: ${ZSH_HIGHLIGHT_STYLES[process-substitution]:=fg=$c[pnpurpblue]}
: ${ZSH_HIGHLIGHT_STYLES[rc-quote]:=fg=$c[testval]}
: ${ZSH_HIGHLIGHT_STYLES[redirection]:=fg=$c[ice],bold}
: ${ZSH_HIGHLIGHT_STYLES[reserved-word]:=fg=$c[softyellow]}
: ${ZSH_HIGHLIGHT_STYLES[single-hyphen-option]:=fg=$c[softyellow],bold}
: ${ZSH_HIGHLIGHT_STYLES[single-quoted-argument]:=fg=$c[green]}
: ${ZSH_HIGHLIGHT_STYLES[suffix-alias]:=fg=$c[testval]}
: ${ZSH_HIGHLIGHT_STYLES[unknown-token]:=}
