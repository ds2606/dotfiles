# ZSH FUNCTIONS

# toggle desktop icons
tdi() {
	val=$(defaults read com.apple.finder CreateDesktop)
	if [ "$val" = "0" ]
		then
			defaults write com.apple.finder CreateDesktop 1
			echo ds icons on
		else
			defaults write com.apple.finder CreateDesktop 0
			echo ds icons off
		fi
	killall Finder
}

# creates a new terminal window
new() {
	if [ $# -eq 0 ]
		then
			open -a "Terminal" "$PWD"
		else
			open -a "Terminal" "$@"
	fi
}

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

# switch workspace
spc() {
	if [[ "$#" -ne 1 ]]; then
		echo "usage: space [ARG]"
		return 1
	fi

	local bg="/users/dschreck/desktop/dropbox/.dotfiles/backgrounds/"
	case $1 in
		"221")
			bg+="lights.jpg"
			;;
		"231n")
			bg+="garden.jpg"
			;;
		"230")
			bg+="stars.jpg"
			;;
		"stat")
			bg+="swirl.jpg"
			;;
		*) 
			echo "space not recognized"
			return 1
			;;
	esac
	
	sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$g'";	
	killall Dock

