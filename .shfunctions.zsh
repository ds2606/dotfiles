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
    if [[ $# == 0 ]]; then
        echo "Usage: launch [-l] application[s]"
    else
        local SEARCH_PATHS=( "/Applications" "/System/Applications" )  # what does the local keyword specifically do in bash?
        [[ $1 == "-l" ]] && _list=1 && shift || _list=0
        for var in "$@"; do
            app=$(fd "$var" "$SEARCH_PATHS[@]" -d 1)
            if [[ $(rg -c . <<< "$app") > 1 ]]; then
                echo "$_RED\0Multiple matches for $_MAGENTA\"$var\"$_RED found:$_NONE\n$app" # if multiple matches found, list and return
            elif [ -z "$app" ]; then
                echo "$_MAGENTA\"$var\" not found$_NONE" # if no matches found, inform caller
            else [[ $_list == 0 ]] && open "$app" || echo "$_CYAN\0Found app at path: $_GREEN\0$app$_NONE"  # if one match, launch (or list if '-l' given)
            fi
        done
    fi
}

# mkdir and cd into it
mcd() {
    if [ $# -eq 1 ]; then
        if [ -d "$1" ]; then
            echo dir exists
        else
            mkdir -p "$1"
        fi
        cd "$1"
    else
        echo 'usage: mcd [dir path]'
    fi
}

# jump straight to a man page flag
mfl () {
    LESS=+/^[[:blank:]]+"$2" man "$1"
}

# switch workspace
spc() {
    if [[ "$#" -ne 1 ]]; then
        echo "usage: space [ARG]"
        return 1
    fi

    local bg="/Users/dschreck/Pictures/backgrounds/"
    case $1 in
        "41") bg+="lights.jpg" ;;
        "231n") bg+="garden.jpg" ;;
        "124") bg+="stars.jpg" ;;
        "110") bg+="swirl.jpg" ;;
        *) echo "space not recognized" && return 1 ;;
    esac
    osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$bg\""
}
