# ZSH FUNCTIONS

# mkdir and cd into it
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

}

# change extension
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
            ?) echo $usagestring && return 1;;

        esac
    done
    shift $((OPTIND - 1))
    [[ $_delete ]] && set $1 'empty'
    [[ $# -ne 2 ]] && echo $usagestring && return 1
    [[ $_append && $_delete ]] && echo "chex: -a and -d flags are mutually exclusive" && return 1

    local _file _old_ext _new_ext _newpath
    _file=$1
    _old_ext=${_file##*.}
    _new_ext=$2

    ! [[ -e "$_file" ]] && echo "$_CYAN$_file$_NONE does not exist." && return 1
    if [[ $_append ]]; then
        _newpath="${_file}.${_new_ext}"
    elif [[ $_delete ]]; then
        _newpath=$(echo $_file | sed "s/\.[[:alnum:]]*$//")
    else
        _newpath=$(echo $_file | sed "s/\(.*\)$_old_ext/\1$_new_ext/")
    fi

    if [[ -e "$_newpath" && -z $_force ]]; then
        echo "$_CYAN$_newpath$_NONE already exists." && return 1
    elif [[ $_dryrun ]]; then
        echo "would move $_CYAN$_file$_NONE to $_GREEN$_newpath$_NONE"
    else
        /bin/mv "$_file" "$_newpath" || { echo 'failure' && return 1; }
        [[ $_quiet ]] || echo "moved $_CYAN$_file$_NONE to $_GREEN$_newpath$_NONE"
    fi
}

# jump straight to a man page section
alias mj='manjump'
manjump() {
    LESS="+/^[[:blank:]]*""$2" man "$1"
}

# shell information catch-all (similar to iPython '?' directive)
alias h='help'
help() {
    local usagestring="usage: help [-a | -l | -m | -t] command"
    local _cmd _cmd_type _follow_alias _linux_cmd _type
    while getopts ":almt" opt; do
        case $opt in
            a) _follow_alias=1;;
            l) man -M "/usr/local/man-linux" "${@:2}"; return;;
            m) man "$2"; return;;
            t) whence -w $2; return;;
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
    local cdir="$(pwd)"
    if [[ "${1}" == "" ]]; then
        cdir="$(dirname "${cdir}")"
    elif ! [[ "${1}" =~ ^[0-9]+$ ]]; then
        echo "Error: argument must be a number"
    else
        for ((i=0; i<${1}; i++)); do
            local ncdir="$(dirname "${cdir}")"
            if [[ "${cdir}" == "${ncdir}" ]]; then
                break
            else
                cdir="${ncdir}"
            fi
        done
    fi
    cd "${cdir}" || return
}

# shadows /usr/local/share/zsh/site-functions/edit-command-line but
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
