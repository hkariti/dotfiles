stty -ixon
export TERM=xterm-256color

# source antidote and load plugins
DOTFILES_DIR=${${(%):-%N}:A:h} # ${(%):-%N} is the location of current file (zshrc)
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load $DOTFILES_DIR/plugins.txt

source $DOTFILES_DIR/clean.zsh-theme

# Completion settings
#if type brew &>/dev/null; then
#    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
#fi
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

function init_ssh_agent() {
    export SSH_AUTH_SOCK=~/.ssh/agent.sock
    [ -e "$SSH_AUTH_SOCK" ] || ln -s ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock "$SSH_AUTH_SOCK"
}

help () {
        man zshbuiltins | sed -ne "s/.//g; /^       $1/,/^\$/{s/       //; p;}"
}

alias 'tmux-ttys'='tmux list-panes -a -F "#{session_name} #{window_index}:#{window_name}.#{pane_index} #{pane_tty}"'

init_ssh_agent

# Lazy load nvm
function nvm {
    unset -f nvm
    export NVM_DIR="/Users/hkariti/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm "$@"
}

# Lazy load pyenv
pyenv () {
	unset -f pyenv
	export PYENV_ROOT="$HOME/.pyenv"
	[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
	pyenv "$@"
}

tmux set-environment -g PATH "$PATH"

if [ -n "$TMUX" ]; then
  function refresh_env {
    export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
    export $(tmux show-environment | grep "^DISPLAY")
  }
else
  function refresh_env { }
fi

alias vzf="fd -H -t f | fzf --preview='bat -f {}' --bind 'enter:become(vim {})'"

function review-changes {
    if [ "$1" = "--help" ]; then
        echo Usage: $0 '[COMMIT]'
        echo
        echo Open Vimdiff on all files in working dir against HEAD or COMMIT
        return 0
    fi
    vim -c ":G difftool -y $1 | :1tabc"
}
