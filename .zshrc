stty -ixon
export TERM=xterm-256color

source <(antibody init)
antibody bundle < ~/repo/dotfiles/plugins.zsh
source ~/repo/dotfiles/clean.zsh-theme

# Completion settings
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _list _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' condition false
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format '%d:'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' match-original 1
zstyle ':completion:*' matcher-list '' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=long
zstyle ':completion:*' path-completion false
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose true
zstyle ':completion:*' word false
autoload -Uz compinit
compinit
bindkey -e

# Fucking proper history nagivation
bindkey "^[OA" up-line-or-history
bindkey "^[OB" down-line-or-history
bindkey "^U" backward-kill-line
bindkey "^W" bash-backward-kill-word

WORDCHARS=
zle -N bash-backward-kill-word
function bash-backward-kill-word {
    local WORDCHARS="${WORDCHARS:s/\s//}/*?_.[]-~=&;#%^(){}<>'"'"$!|'
    zle backward-kill-word
}

# Various settings
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
setopt appendhistory nomatch notify interactivecomments
unsetopt autocd beep extendedglob sharehistory

function init_ssh_agent {
    if [ -z "$SSH_AUTH_SOCK" ]; then
        SSH_AGENT_PID=`pgrep -u $USER ssh-agent`
        [ -z "$SSH_AGENT_PID" ] && return
        SSH_AUTH_SOCK=`find /tmp/ssh-* -name "agent.*" -user $USER`
        export SSH_AUTH_SOCK SSH_AGENT_PID
    fi

    ssh-add -l &>/dev/null || ssh-add -t $((60*60*1))
}

function commit_dotfiles() (
    cd ~/repo/dotfiles
    git add .
    git commit
    git push
)

function realpath {
    [ -z "$1" ] && return 1
    case "`uname`" in
        Linux)
            readlink -f "$1"
            ;;
        Darwin)
            command realpath "$1"
            ;;
        *)
            echo "Unknown os">&2
            return 1
            ;;
    esac
}

function root {
    if [ "$1" ]; then
        SESSION_ROOT=`realpath "$1"`
        echo Session root is now $SESSION_ROOT
    fi
    if [ -z "$SESSION_ROOT" ]; then
        tmux_session=`tmux display-message -p '#S'`
        [ -z "$tmux_session" ] && return
        root=`grep root: ~/.tmuxinator/"$tmux_session".yml | cut -d' ' -f 2-`
        [ -z "$root" ] && return
        SESSION_ROOT=$root
        echo Autodetected session root to be $SESSION_ROOT
    fi
    eval cd $SESSION_ROOT
}

help () {
        man zshbuiltins | sed -ne "s/.//g; /^       $1/,/^\$/{s/       //; p;}"
}

## enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls --color=auto'
#    #alias dir='dir --color=auto'
#    #alias vdir='vdir --color=auto'
#
#    alias grep='grep --color=auto'
#    alias fgrep='fgrep --color=auto'
#    alias egrep='egrep --color=auto'
#fi
#
## some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias work='cd repo/bigpanda'
#alias docker='sudo docker -H :1337'

alias generate_hosts="{ cat /etc/hosts.base; sed -n '/###/,$ p' hosts/hosts-with-locals; } | sudo tee /etc/hosts"

alias devbox='cd ~/repo/bigpanda/operations/devbox'
alias 'tmux-ttys'='tmux list-panes -a -F "#{session_name} #{window_index}:#{window_name}.#{pane_index} #{pane_tty}"'

init_ssh_agent

#prompt="%n@%m:%~%# "

# Lazy load nvm
function nvm {
    unset nvm
    export NVM_DIR="/Users/hkariti/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm "$@"
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# added by travis gem
[ -f /Users/hkariti/.travis/travis.sh ] && source /Users/hkariti/.travis/travis.sh
