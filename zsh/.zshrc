stty -ixon
export TERM=xterm-256color

# source antidote and load plugins
DOTFILES_DIR=${${(%):-%N}:A:h} # ${(%):-%N} is the location of current file (zshrc)
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
zstyle ':antidote:bundle' file $DOTFILES_DIR/plugins.zsh
antidote load

source $DOTFILES_DIR/clean.zsh-theme

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

setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.

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

    ssh-add -l &>/dev/null || ssh-add -t $((60*60*12))
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

alias 'tmux-ttys'='tmux list-panes -a -F "#{session_name} #{window_index}:#{window_name}.#{pane_index} #{pane_tty}"'

#init_ssh_agent

# Lazy load nvm
function nvm {
    unset -f nvm
    export NVM_DIR="/Users/hkariti/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm "$@"
}

# Lazy load rvm
function rvm {
    unset -f rvm
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
    rvm "$@"
}

# Load conda if not loaded
function conda {
    unset -f conda
    source ~/miniconda3/etc/profile.d/conda.sh
    conda "$@"
}

tmux set-environment -g PATH "$PATH"
