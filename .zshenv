export EDITOR="vim"
export PATH=$PATH:~/bin
export GOPATH=$HOME/golang
if [ "`uname -s`" = "Darwin" ]; then
    export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
    export SHELL="/usr/local/bin/zsh"
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    tmux set-environment -g PATH "$PATH"
elif [ "`uname -s`" = "Linux" ]; then
    export VAGRANT_DEFAULT_PROVIDER=lxc
fi
