# ZSH FUNCTIONS
#
# some ANSI color codes
_RED="\033[31m"
_CYAN="\033[94m"
_NONE="\033[0m"
_GREEN="\033[92m"
_MAGENTA="\033[95m"

# toggle desktop icons
tdi() {
    val=$(defaults read com.apple.finder CreateDesktop)
    if [ "$val" = "0" ]; then
        defaults write com.apple.finder CreateDesktop 1
        echo ds icons on
    else
        defaults write com.apple.finder CreateDesktop 0
        echo ds icons off
    fi
    killall Finder
}

# launch a GUI application (optionally list matches if '-l' given)
alias l='launch'
launch() {
    [[ $# == 0 ]] && echo "Usage: launch [-l] application[s]" && return 1
    local SEARCH_PATHS=( "/Applications" "/System/Applications" )
    [[ $1 == "-l" ]] && local _list=1 && shift
    for var in "$@"; do
        app=$(fd "$var" "${SEARCH_PATHS[@]}" -d 1)
        if [[ $(rg -c . <<< "$app") -gt 1 ]]; then
            echo "$_RED\0Multiple matches for $_MAGENTA\"$var\"$_RED found:$_NONE\n$app" # if multiple matches found, list and return
        elif [ -z "$app" ]; then
            echo "$_MAGENTA\"$var\"$_RED not found$_NONE" # if no matches found, inform caller
        elif [[ $_list == 1 ]]; then
            echo "\0Found app $_CYAN\0$(basename "$app" | cut -d . -f 1)\0$_NONE at path: $_GREEN\0$app$_NONE" # list match if '-l' given
        else
            open "$app"
        fi
    done
}

# mkdir and cd into it
mcd() {
    if [ $# -eq 1 ]; then
        if [ -d "$1" ]; then
            echo 'dir exists'
        else
            mkdir -p "$1"
        fi
        cd "$1" || exit
    else
        echo 'usage: mcd [dir path]'
    fi
}

# change extension
## maybe update this to handle hidden files by stripping a leading dot
chex() {
    [[ $1 == "-q" ]] && local _quiet=1 && shift
    if [[ $# -ne 2 ]]; then
        echo 'usage: chex [-q] [file] [new-extension]'
        return 1
    fi

    local file old_ext new_ext newpath
    file=$1
    old_ext=${file##*.}
    new_ext=$2
    newpath=$(echo $file | sed "s/\(.*\)$old_ext/\1$new_ext/")
    mv "$file" "$newpath" || return 1
    [[ $_quiet -ne 1 ]] && echo "moved $_CYAN$file$_NONE to $_GREEN\0$newpath$_NONE"
}

# jump straight to a man page flag
mfl() {
    LESS="+/^[[:blank:]]+""$2" man "$1"
}

# make a phone call
call() {
    open -a facetime tel://"$1"
}

# nest tmux nessions
# UPDATE WITH GETOPTS instead of this janky flag catching
## could make invocation code paths for different flag/arg combinations much cleaner in
## general (e.g. 'tmux_nested a b c d e f g' code path should be cleanly handled)
tmux_nested() {
    if [[ -z $TMUX ]]; then
        # ensure invoked within active session
        echo "'tmux_nested' should be invoked inside an active tmux session"
        return 1
    elif [[ $# -eq 0 ]]; then
        # if invoked without flags, print usage string and exit
        echo 'usage: tmux-nested <[-n] | [-a nested-session-number] | [-l]>'
        return 1
    fi

    # read flags and check for number of existing nested sessions
    local nested_sessions session_name
    nested_sessions=$(tmux list-sessions -F '#{session_name}' | ggrep -P '^nested' --color=never | sort -V)
    [[ $1 == "-n" ]] && local _new=1 && shift
    [[ $1 == "-a" ]] && local _attach=1 && shift
    [[ $1 == "-l" ]] && echo "$nested_sessions" && return 0

    if [[ $_new -eq 1 ]]; then
        # if new session requested: create, set <C-b> tmux prefix, and attach
        for (( i = 1;; i++ )); do
            # get lowest available numeric value for new session name
            grep -Pq "\w$i$" <<< "$nested_sessions"  # debug? sometimes the '$' anchor seems to be failing for the herestring '\n' newline literals
            [[ $? -eq 1 ]] && session_name="nested$i" && break
        done
        env TMUX='' tmux new-session -ds "$session_name"
        tmux send-keys -t "$session_name" "tmux set prefix C-b" ENTER "clear" ENTER
        env TMUX='' tmux attach -t "$session_name" || return
    # attach to specified session if requested
    elif [[ $_attach -eq 1 ]]; then
        session_name="nested$1"
        if ! env TMUX='' tmux attach -t "$session_name"; then
            echo "list existing nested sessions with 'tmux_nested -l'"
            return
        fi
    fi
}

# switch wallpaper
wp() {
    if [[ "$#" -ne 1 ]]; then
        echo "usage: wp [ARG]"
        return 1
    fi

    local bg="/Users/dschreck/Pictures/backgrounds/"
    case $1 in
        "lights") bg+="lights.jpg" ;;
        "garden") bg+="garden.jpg" ;;
        "stars") bg+="stars.jpg" ;;
        "swirl") bg+="swirl.jpg" ;;
        *) echo "wallpaper not recognized" && return 1 ;;
    esac
    osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$bg\""
}

# shell information catch-all (similar to iPython '?' directive)
alias h='help'
help () {
    local _cmd=$1 _linux_cmd _cmd_type
    [[ $_cmd == "-l" ]] && _linux_cmd=1 && shift
    if [[ $# -ne 1 ]]; then
        echo "usage: help [-l] command" && return 1
    fi
    _cmd_type=$(whence -w "$_cmd" | cut -d ' ' -f 2)
    case $_cmd_type in
        "alias")
            which "$_cmd"
            ;;
        "builtin")
            LESS="+/^[[:blank:]]+""$1" man "zshbuiltins"
            ;;
        "command")
            if [[ "$_linux_cmd" ]]; then
                man -M "/usr/local/share/man-linux" "$_cmd"
            else
                man "$_cmd"
            fi
            ;;
        "function")
            which "$_cmd" | bat -p -l sh
            ;;
        "hashed")
            echo "$_cmd: support for hashed commands not yet implemented"
            ;;
        "reserved")
            whence -v "$_cmd"
            ;;
        "none")
            man "$_cmd" 2> /dev/null || echo "$_cmd is not a recognized command." && return 1
            ;;
    esac
}
