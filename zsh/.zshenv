export EDITOR="vim"
export GOPATH=$HOME/golang
if [ "`uname -s`" = "Darwin" ]; then
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    if [ "`uname -p`" = arm ]; then
        export HOMEBREW_PREFIX="/opt/homebrew";
        export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
        export HOMEBREW_REPOSITORY="/opt/homebrew";
        export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
        export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
    fi
elif [ "`uname -s`" = "Linux" ]; then
    export VAGRANT_DEFAULT_PROVIDER=lxc
fi

if [[ $SHLVL == 1 && ! -o LOGIN  ]]; then
    source ~/.zpath
fi
