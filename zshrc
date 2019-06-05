#Use this only for profiling ZSH
#zmodload zsh/zprof

# Load private settings... if found
if [ -f ~/.zshrc_privateSettings ]; then
    source ~/.zshrc_privateSettings
fi

# Theme configuration
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_TIME_BACKGROUND='239'

POWERLEVEL9K_CONTEXT_TEMPLATE='%B%n%b@%m'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='blue'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='235'
POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND='red'
POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND='grey'

POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='235'
POWERLEVEL9K_DIR_HOME_BACKGROUND='6'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='6'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='6'
POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_DIR_NOT_WRITABLE_BACKGROUND='3'


POWERLEVEL9K_VIRTUALENV_BACKGROUND='green'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator rbenv virtualenv background_jobs)

#Fix wrong terminal colors when using tmux
#because xfce term do not have the right $TERM setting
if [ "$COLORTERM" = "gnome-terminal" -a "$TERM" = "xterm" ]; then
        export TERM=xterm-256color
fi
if [ "$COLORTERM" = "xfce4-terminal" -a "$TERM" = "xterm" ]; then
        export TERM=xterm-256color
fi

ENABLE_CORRECTION="true" #enable correction of mistyped commands
COMPLETION_WAITING_DOTS="true" #display red dots whilst waiting for completion

# OLD ANTIGEN CONFIG using Prezto
# Todo : new tools exa for ls, fd for find, ripgrep for grep
# POWERLEVEL9K_INSTALLATION_PATH=$HOME/.antigen/bundles/bhilburn/powerlevel9k/powerlevel9k.zsh-theme
# source ~/.antigen/antigen.zsh
# #export NVM_LAZY_LOAD=true
# #antigen bundle lukechilds/zsh-nvm
# antigen use prezto
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239'
# antigen bundle sorin-ionescu/prezto modules/utility
# antigen bundle sorin-ionescu/prezto modules/command-not-found
# antigen bundle sorin-ionescu/prezto modules/helper #required for git
# antigen bundle sorin-ionescu/prezto modules/git
# #antigen bundle sorin-ionescu/prezto modules/node
# antigen bundle sorin-ionescu/prezto modules/rsync
# antigen bundle sorin-ionescu/prezto modules/tmux
# antigen bundle sorin-ionescu/prezto modules/history
# antigen bundle robbyrussell/oh-my-zsh plugins/virtualenvwrapper
# #THEME
# antigen theme bhilburn/powerlevel9k powerlevel9k
# #Should be the last to load
# antigen bundle sorin-ionescu/prezto modules/completion
# antigen bundle sorin-ionescu/prezto modules/fasd
# antigen bundle robbyrussell/oh-my-zsh plugins/docker # docker autocompletions
# antigen bundle robbyrussell/oh-my-zsh plugins/kubectl # K8s autocompletions
# antigen bundle zsh-users/zsh-syntax-highlighting #Prezto module seems broken
# antigen bundle sorin-ionescu/prezto modules/history-substring-search
# antigen bundle sorin-ionescu/prezto modules/autosuggestions

#ANTIGEN new config back with oh-my-zsh
POWERLEVEL9K_INSTALLATION_PATH=$HOME/.antigen/bundles/bhilburn/powerlevel9k/powerlevel9k.zsh-theme
source ~/.antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle colored-man-pages
antigen bundle common-aliases
antigen bundle docker
antigen bundle git
antigen bundle kubectl
antigen bundle fasd # use j <FolderName> to jump or v FileName to edit
antigen bundle fd # find replacement auto-completion
if [ -x "$(command -v fzf)" ]; then
    antigen bundle fzf # fuzzy auto complete (Ctrl - T for files) (Ctrl - R for history)
fi
antigen bundle rand-quote # run 'quote'
antigen bundle rsync
antigen bundle sudo # add sudo in front of last CMD with ESC ESC combo
antigen bundle virtualenvwrapper
antigen bundle zsh_reload # reloads zsh config by running 'src'

antigen bundle sorin-ionescu/prezto modules/completion # because it's better than Oh-my-ZSH

#THEME
antigen theme bhilburn/powerlevel9k powerlevel9k
#Others
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239' 
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions # Additional completion files
antigen bundle zsh-users/zsh-syntax-highlighting #needs to be loaded before history-substring search
antigen bundle zsh-users/zsh-history-substring-search # search a substring in history with arrow keys

antigen apply

## @Todo later : 
# pipenv 
# direnv a tool for sourcing env files in directories
# mosh plugin Do I still use mosh ?
# find somewhere to display quotes
# Scaleway autocomplete : https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/scw
# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/terraform


### User configuration

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# Add yarn global bin path to PATH
if [ -x "$(command -v yarn)" ]; then
    export PATH="$PATH:$(yarn global bin)"
fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR="vim"

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"



# Set personal aliases
alias tmux="tmux -2"
alias gwdiff="git diff --word-diff=color -b -w --ignore-blank-lines --ignore-space-at-eol"
alias gdiff="git diff --ignore-space-at-eol -b -w --ignore-blank-lines"

alias ls="ls --color=auto -F" #shows trailing / at the end of DirNames
alias ll="ls -hl"
alias la="ls -hal"

# Grep aliases if rg is detected
if [ -x "$(command -v rg)" ]; then
    alias grep='rg'
fi

#git aliases
alias git_word-diff="git diff --color-words=."
alias mux="tmuxinator"

# Oh-my-zsh overrides the fd alias. Change to use the fd command if installed.
unalias fd
if [ ! -x "$(command -v fd)" ]; then
    alias fd='find . -type d -name'
fi



# # Completion settings
# zstyle ':completion:*' format '%B --- %d --- %b'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
# zstyle ':completion:*:warnings' format "%B$fg[red]%}---- no match for: $fg[white]%d%b"
# zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # ls colors in completion
# # activate approximate completion, but only after regular completion (_complete)
# zstyle ':completion:::::' completer _complete _approximate
# # limit to 2 errors
# zstyle ':completion:*:approximate:*' max-errors 2
# # or to have a better heuristic, by allowing one error per 3 character typed
# # zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
# zstyle ':completion:*' menu select


#To make tilix happy
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

#Display neofetch
if command -v neofetch >/dev/null 2>&1; then
	alias clear="clear; neofetch"
	neofetch
fi

#Use for debugging startup time
#zprof
