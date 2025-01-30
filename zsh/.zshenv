export EDITOR="vim"
export GOPATH=$HOME/golang
export DVC_PAGER='bat -p --wrap=never --color=never'
if [ "`uname -s`" = "Darwin" ]; then
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
elif [ "`uname -s`" = "Linux" ]; then
    export VAGRANT_DEFAULT_PROVIDER=lxc
fi

if [[ $SHLVL == 1 && ! -o LOGIN  ]]; then
    source ~/.zpath
fi
