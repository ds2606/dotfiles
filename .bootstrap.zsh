# Initialize dotfiles
ln -s "~/Desktop/Dropbox/dotfiles" "~/.dotfiles"
ln -s "~/.dotfiles/.vimrc" "~/.vimrc"
ln -s "~/.dotfiles/.tmux.conf" "~/.tmux.conf"
ln -s "~/.dotfiles/.gitconfig" "~/.gitconfig"

# Install Homebrew formulae
source "~/.dotfiles/.brewfile"

# Initialize vim
mkdir "~/.vim/undo"
mkdir "~/.vim/tmp"
mkdir "~/.vim/backups"
ln -s "~/.dotfiles" "~/.vim/coc-settings.json"
ln -s "~/.dotfiles/colors/palenight/pn-colors.vim" "~/.vim/colors/palenight.vim"
ln -s "~/.dotfiles/colors/palenight/pn-autoload.vim" "~/.vim/autoload/palenight.vim"
ln -s "~/.dotfiles/colors/palenight/pn-lightline.vim" "~/.vim/plugged/lightline.vim/autoload/lightline/colorscheme/palenight.vim"

# To initialize zsh syntax highlighting colorscheme, insert following line at top of
# /opt/homebrew/share/zsh-syntax-highlighting/highlighters/main/main-highlighter.zsh:
## source custom highlighting
## source $HOME/.dotfiles/colors/palenight/pn-syntax.zsh

# Initialize iPython
ln -s "~/.dotfiles/.ipyrc" "~/.ipython/profile_dschreck/startup/ipyrc.py"
ln -s "~/.dotfiles/.ipython_config" "~/.ipython/profile_dschreck/ipython_config.py"
