# set up ssh environment on remote host

if [[ $# -ne 2 ]]; then
    echo 'usage: sync-remote-env <user> <host>'
    exit 1
fi
user=$1 host=$2

# test that we can connect to remote host, abort if unreachable
ssh -q -o BatchMode=yes  -o StrictHostKeyChecking=no -o ConnectTimeout=5 "$host" "exit 0"
[[ $? -ne 0 ]] && echo "Could not connect to remote host. Aborting..." && exit 1

echo "Syncing local configuration files with remote: $host"
rsync -rLz ~/.dotfiles/ssh-env $host:~
ssh $user@$host $(cat << EOF
ln -sf ~/ssh-env/tmux.conf ~/.tmux.conf;
ln -sf ~/ssh-env/vimrc ~/.vimrc;
ln -sf ~/ssh-env/gitconfig ~/.gitconfig;
ln -sf ~/ssh-env/coc-settings.json ~/.coc-settings.json;
rm -f ~/ssh-env/sync-ssh-env.zsh
EOF
)
echo "Done!"
