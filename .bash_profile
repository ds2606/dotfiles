# BASH PROFILE

# source functions
source $HOME/.dotfiles/.shfunctions

# set prompt
PS1='\[\033[01;34m\](bash) \w> \[\033[00m\]'

# set paths
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-14.0.2.jdk/Contents/Home
export PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
export PATH="$PATH:/usr/local/smlnj/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/.opt/bin"

# set paths
export BASH_SILENCE_DEPRECATION_WARNING=1
export PYTHONDONTWRITEBYTECODE=1
export PATH="$HOME/.cargo/bin:$PATH"

# set environment variables
export PYTHONDONTWRITEBYTECODE=1
export BASH_SILENCE_DEPRECATION_WARNING=1

# safe environment
set -o noclobber
alias rm='rm -i'         # Prompt before removing files via 'rm'
alias cp='cp -i'         # Prompt before overwriting files via 'cp'
alias mv='mv -i'         # Prompt before overwriting files via 'mv'
alias ln='ln -i'         # Prompt before overwriting files via 'ln'

# navigation shortcuts
alias ,="cd -"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
cs=~/Dropbox/cs # any trouble with alias and var having same name?
alias cs="cd ~/Desktop/Dropbox/cs"
alias dotfiles="cd ~/Desktop/Dropbox/.dotfiles"

# command aliases
alias python="python3"
alias l='ls -lahG'
alias ls='ls -G'
alias grep='ggrep --color=auto' # GNU grep as default
alias less='less -m'

# application shortcuts
alias chrome='open -a Google\ Chrome'
alias finder='open -a Finder'

# history tweaks
shopt -s histappend # on shell exit, append instead of overwrite 
export HISTCONTROL=erasedups:ignoredups # ignore duplicate command lines.
export HISTTIMEFORMAT="%F %T " # show dates and times.
