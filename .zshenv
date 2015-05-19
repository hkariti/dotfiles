export EDITOR="vim"
export PATH=$PATH:~/bin
if [ "`uname -s`" = "Darwin" ]; then
    export PATH="/usr/local/sbin:$PATH"
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
    export SHELL="/usr/local/bin/zsh"
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    tmux set-environment -g PATH "$PATH"
elif [ "`uname -s`" = "Linux" ]; then
    export VAGRANT_DEFAULT_PROVIDER=lxc
fi
