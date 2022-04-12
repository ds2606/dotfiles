# ZSH FUNCTIONS

# mkdir and cd into it
mcd() {
	if [ $# -eq 1 ]
		then
			mkdir -p "$1"
			cd "$1"
		else
			echo 'usage: mcd [dir path]'
	fi
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
    LESS="+/^[[:blank:]]+""$2" man "$1"
}

# shell information catch-all (similar to iPython '?' directive)
alias h='help'
help() {
    local _cmd=$1 _cmd_type
    if [[ $_cmd == "-l" ]]; then
        man -M "/usr/local/man-linux" "${@:2}"
        return
    elif [[ $# -ne 1 ]]; then
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
            fi;;
    esac
}
