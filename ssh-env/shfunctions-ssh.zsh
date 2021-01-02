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
