export EDITOR="vim"
export GOPATH=$HOME/golang
export AWS_PROFILE=dev-k8s
if [ "`uname -s`" = "Darwin" ]; then
    export EVENT_NOKQUEUE=1
    export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
    export SHELL="/usr/local/bin/zsh"
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    tmux set-environment -g PATH "$PATH"
elif [ "`uname -s`" = "Linux" ] && hostname | grep -q hep.technion; then
    # Atlas cluster
    source /storage/md_kaplan/anaconda3/bin/activate
    export MKL_NUM_THREADS="1"
    export NUMEXPR_NUM_THREADS="1"
    export OMP_NUM_THREADS="1"
fi

if [[ $SHLVL == 1 && ! -o LOGIN  ]]; then
    source ~/.zpath
fi
