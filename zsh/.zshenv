export EDITOR="vim"
export GOPATH=$HOME/golang
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

export LOCAL_WHATSAPP_NUMBER=972525513042
export WHATSAPP_NUMBER=972587786028
export WHATSAPP_CERTIFICATE=blablablalbla
export SERVICES=~/repo/riseup
export BOB_DIR=~/repo/riseup/bob
