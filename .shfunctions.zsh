# ZSH FUNCTIONS

# Some ANSI color codes
_RED="\033[31m"
_CYAN="\033[94m"
_NONE="\033[0m"
_GREEN="\033[92m"
_MAGENTA="\033[95m"

# Mkdir and cd into it
mcd() {
    if [ $# -eq 1 ]; then
        if [ -d "$1" ]; then
            echo "dir exists, changing pwd to ./$1"
        else
            mkdir -p "$1"
        fi
        cd "$1" || return 1
    else
        echo 'usage: mcd [dir path]'
    fi
}

# Toggle desktop icons
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

# Launch a GUI application (optionally list matches if '-l' given)
alias l='launch'
launch() {
    [[ $# == 0 ]] && echo "Usage: launch [-l | -o] application[s]" && return 1
    [[ $1 == "-l" ]] && local _list=1 && shift
    [[ $1 == "-o" ]] && local _open=1 _file=$2 && shift 2
    local app SEARCH_PATHS=( "/Applications" "/System/Applications" ) var
    for _var in "$@"; do
        _app=$(fd "$_var" "${SEARCH_PATHS[@]}" -d 1)
        if [ -z "$_app" ]; then
            # no matches: exit
            echo "$_MAGENTA\"$_var\"$_RED not found$_NONE"
            return 1
        elif [[ $(rg -c . <<< "$_app") -gt 1 ]]; then
            # multiple matches: list and exit
            echo "$_RED\0Multiple matches for $_MAGENTA\"$_var\"$_RED found:$_NONE\n$_app"
            return 1
        elif [[ $_list == 1 ]]; then
            # exact match and '-l' given: list path
            echo "\0Found app $_CYAN\0$(basename "$_app" | cut -d . -f 1)\0$_NONE at path: $_GREEN\0$_app$_NONE"
        elif [[ $_open == 1 ]]; then
            open -a "$_app" "$_file"
        else
            open "$_app"
        fi
    done
}

# Change an extension
chex() {
    local usagestring='usage: chex [-h | flags] <file> <new-extension>'
    local _append _delete _dryrun _force _quiet
    while getopts ":adfhnq" opt; do
        case $opt in
            a) _append=1;;
            d) _delete=1;;
            f) _force=1;;
            n) _dryrun=1;;
            q) _quiet=1;;
            h) printf "%s\n" "Change a file extension." ""\
                      "usage: chex [-d|-f|-h|-n|-q] <file> <new extension>"\
                      "  - a: append extension to filename"\
                      "  - d: delete existing extension (<new-extension> is omitted)"\
                      "  - f: force renaming (even if target path already exists)"\
                      "  - h: display this help message and exit"\
                      "  - n: dry-run"\
                      "  - q: quiet" ""\
                      "Note: -a and -d flags are mutually exclusive. Behavior"\
                      "is undefined if both are simultaneously given."
               return;;
            ?) echo "$usagestring" && return 1;;

        esac
    done
    shift $((OPTIND - 1))
    [[ $_delete ]] && set "$1" "null"
    [[ $# -ne 2 ]] && echo "$usagestring" && return 1
    [[ $_append && $_delete ]] && echo "chex: -a and -d flags are mutually exclusive" && return 1

    local _file _old_ext _new_ext _newpath
    _file=$1
    ! [[ -e "$_file" ]] && echo "$_CYAN$_file$_NONE does not exist." && return 1
    _old_ext=${_file##*.}
    _new_ext=$2

    # construct target pathname
    if [[ $_append ]]; then
        _newpath="${_file}.${_new_ext}"
    elif [[ $_delete ]]; then
        _newpath=$(echo "$_file" | sed "s/\.[[:alnum:]]*$//")
    else
        _newpath=$(echo "$_file" | sed "s/\(.*\)$_old_ext/\1$_new_ext/")
    fi

    # move file to target path
    if [[ -e "$_newpath" && -z $_force ]]; then
        echo "$_CYAN$_newpath$_NONE already exists." && return 1
    elif [[ $_dryrun ]]; then
        echo "would move $_CYAN$_file$_NONE to $_GREEN$_newpath$_NONE"
    else
        /bin/mv "$_file" "$_newpath" || { echo 'failure' && return 1; }
        [[ $_quiet ]] || echo "moved $_CYAN$_file$_NONE to $_GREEN$_newpath$_NONE"
    fi
}

# Jump straight to a manpage line
alias mj='manjump'
manjump() {
    LESS="+/^[[:blank:]]*""$2" man "$1"
}

# Make a call by phone, facetime, or skype
call() {
    local usagestring="usage: call [-a | -s | -v] <name | number>"
    while getopts ":an:sv" opt; do
        case $opt in
            a) local ft_audio=1 ;;
            n) local index=$OPTARG ;;
            s) local skype=1 ;;
            v) local facetime=1 ;;
            \?) echo "$usagestring" && return 1 ;;
            :) echo "option -$OPTARG requires an argument." && return 1 1>&2 ;;
        esac
    done
    shift $(( OPTIND - 1))
    [[ $# -eq 0 ]] && echo "$usagestring" && return 1
    local num=$*

    # Handle alphabetic queries (for, e.g., specific names)
    if ggrep -q '.*[[:alpha:]].*' <<< "$*"; then
        # extract number if name is given
        matches=$(~/.dotfiles/bin/contacts "$*" 2> /dev/null)
        if [[ -z $matches ]]; then
            echo "$_RED\0no matches found for $_MAGENTA$*$_RED$_NONE"
            return 1
        fi
        num=$(sed -E 's/.*ue=(.*),.*/\1/' <<< $matches | tr -d ' ')
        local n_matches=$(wc -l <<< "$matches")

        if [[ -n $index ]]; then
            # Handle (optional) user-specified index
            if [[ $index -gt 0 ]] && [[ $index -le $n_matches ]]; then
                num=$(sed -n "$index"p <<< $num)
            else
                echo "Invalid index given: $index"
            fi
        elif [[ $n_matches -gt 1 ]]; then
            # Pretty-print multiple matches if user-specified index given
            printf '%s\n' 'Multiple matches (try `call -n <index> <query>)' \
                          '-----------------------------------------------'
            local names indices
            names=$(echo "$matches" | sed -E 's/(.*) <.*/\1/')
            indices=$(seq $n_matches | sed 's/$/)/')
            paste <(echo "$indices") <(echo "$names") <(echo "$num") | column -s $'\t' -t
            return 1
        fi
    fi

    # Make the call
    if [[ -n $ft_audio ]]; then
        open "facetime-audio://$num"
    elif [[ -n $facetime ]]; then
        open "facetime://$num"
    elif [[ -n $skype ]]; then
        open -a skype "tel://$num"
    else
        open -a facetime "tel://$num"
    fi
}

# Nest tmux sessions
tmux_nested() {
    local usagestring='usage: tmux-nested [-n | -a nested-session-# | -l]'
    if [[ -z $TMUX ]]; then
        # ensure invoked within active session
        echo "'tmux_nested' should be invoked inside an active tmux session"
        return 1
    fi

    # read flags and check for number of existing nested sessions
    local nested session_name
    nested=$(tmux list-sessions -F '#{session_name}' | \
             ggrep -P '^nested[\d]+' --color=never | sort -V)
    while getopts ':lna:' opt; do
        case $opt in
            l)
                [[ -z $nested ]] && nested="No nested sessions running"
                echo "$nested" && return 0;;
            n)
                # if new session requested: create, set <C-b> tmux prefix, and attach
                for (( i = 1;; i++ )); do
                    # get lowest available numeric value for new session name
                    if ! tmux has-session -t "nested$i" 2> /dev/null; then
                        session_name="nested$i" && break
                    fi
                done
                tmux new-session -ds "$session_name"
                tmux send-keys -t "$session_name" \
                                  "tmux set prefix C-b" ENTER "clear" ENTER
                env TMUX='' tmux attach -t "$session_name"
                return $?;;
            a)
                # attach to specified session if requested
                session_name="nested${OPTARG}"
                if ! env TMUX='' tmux attach -t "$session_name"; then
                    echo "Try 'tmux_nested -l'?" && return 1
                fi;;
            *) echo "$usagestring" && return 1;;
        esac
    done

    # incorrect invocation, report incorrect invocation and exit
    echo "$usagestring" && return 1
}

# Shell help-information catch-all
alias h='help'
help() {
    local usagestring="usage: help [-a | -l | -m | -t] command"
    local _cmd _cmd_type _follow_alias _linux_cmd _type
    while getopts ":almt" opt; do
        case $opt in
            a) _follow_alias=1;;
            l) man -M "/usr/local/man-linux" "${@:2}"; return;;
            m) man "$2"; return;;
            t) whence -w "$2"; return;;
            ?) echo "$usagestring"; return 1;;
        esac
    done
    shift $((OPTIND - 1))
    [[ $# -ne 1 ]] && echo "$usagestring" && return 1

    get_cmd_type() { whence -w "$1" | cut -d ' ' -f 2; }
    _cmd=$1
    _cmd_type=$(get_cmd_type "$_cmd")
    if [[ $_follow_alias && $_cmd_type == "alias" ]]; then
        _cmd="$(whence "$_cmd" | cut -d ' ' -f1)"
        _cmd_type=$(get_cmd_type "$_cmd")
        if [[ "$_cmd_type" == "alias" ]]; then
            # for self-referential aliases
            man "$_cmd"
            return
        fi
    fi

    case $_cmd_type in
        "alias")
            which "$_cmd"
            ;;
        "builtin")
            LESS="+/^[[:blank:]]+""$1" man "zshbuiltins"
            ;;
        "command")
            man "$_cmd"
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
            if ! man "$_cmd" 2> /dev/null; then
                echo "$_cmd is not a recognized command." && return 1
            fi
            ;;
    esac
}

# Go up [n] directories (from anishathalye)
up()
{
    local cdir
    cdir="$(pwd)"
    if [[ "${1}" == "" ]]; then
        cdir="$(dirname "${cdir}")"
    elif ! [[ "${1}" =~ ^[0-9]+$ ]]; then
        echo "Error: argument must be a number"
    else
        for ((i=0; i<${1}; i++)); do
            local ncdir
            ncdir="$(dirname "${cdir}")"
            if [[ "${cdir}" == "${ncdir}" ]]; then
                break
            else
                cdir="${ncdir}"
            fi
        done
    fi
    cd "${cdir}" || return
}

# Shadows /usr/local/share/zsh/site-functions/edit-command-line but
# edits the command line in-place (i.e. does not invoke `send-break`, thereby not
# exiting with error-status and redrawing the prompt)
edit-command-line() {
    emulate -L zsh

    () {
        exec </dev/tty

        # Compute the cursor's position in bytes, not characters.
        setopt localoptions nomultibyte noksharrays
        (( $+zle_bracketed_paste )) && print -r -n - $zle_bracketed_paste[2]

        # Open the editor, placing the cursor at the right place if we know how.
        local editor=( "${(@Q)${(z)${VISUAL:-${EDITOR:-vi}}}}" )
        case $editor in
            (*vim*)
                integer byteoffset=$(( $#PREBUFFER + $#LBUFFER + 1 ))
                "${(@)editor}" -c "normal! ${byteoffset}go" -- $1;;
            (*emacs*)
                local lines=( "${(@f):-"$PREBUFFER$LBUFFER"}" )
                "${(@)editor}" +${#lines}:$((${#lines[-1]} + 1)) $1;;
            (*)
                "${(@)editor}" $1;;
        esac

        (( $+zle_bracketed_paste )) && print -r -n - $zle_bracketed_paste[1]

        # # Replace the buffer with the editor output.
        BUFFER="$(<$1)"

    } =(<<<"$PREBUFFER$BUFFER")
}
