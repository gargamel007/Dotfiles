POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_TIME_BACKGROUND='239'
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


#### DEPRECATED OMZ Config just keeping this as a backup just in case
# Path to your oh-my-zsh installation.
# export ZSH=$HOME/.oh-my-zsh
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# ZSH_THEME="agnoster"
# ZSH_THEME="pygmalion"
# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
#plugins=(git command-not-found common-aliases colored-man sudo tmux z docker tmuxinator virtualenvwrapper pip)
#source $ZSH/oh-my-zsh.sh

#ANTIGEN CONFIG
POWERLEVEL9K_INSTALLATION_PATH=$HOME/.antigen/bundles/bhilburn/powerlevel9k/powerlevel9k.zsh-theme
source ~/.antigen/antigen.zsh
antigen use prezto
antigen bundle sorin-ionescu/prezto modules/autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239'
antigen bundle sorin-ionescu/prezto modules/command-not-found
antigen bundle sorin-ionescu/prezto modules/helper #required for git
antigen bundle sorin-ionescu/prezto modules/git
antigen bundle sorin-ionescu/prezto modules/python
antigen bundle sorin-ionescu/prezto modules/node
antigen bundle sorin-ionescu/prezto modules/rsync
antigen bundle sorin-ionescu/prezto modules/ssh
antigen bundle sorin-ionescu/prezto modules/tmux
antigen bundle sorin-ionescu/prezto modules/history
#THEME
antigen theme bhilburn/powerlevel9k powerlevel9k
#Should be the last to load
antigen bundle sorin-ionescu/prezto modules/completion
antigen bundle zsh-users/zsh-syntax-highlighting #Prezto module seems broken
antigen bundle sorin-ionescu/prezto modules/history-substring-search

antigen apply
# User configuration

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias tmux="tmux -2"
alias gwdiff="git diff --word-diff=color -b -w --ignore-blank-lines --ignore-space-at-eol"
alias gdiff="git diff --ignore-space-at-eol -b -w --ignore-blank-lines"
alias ls="ls --color=auto -F" #shows trailing / at the end of DirNames
alias ll="ls -hl"
alias la="ls -hal"
#git aliases
alias git_word-diff="git diff --color-words=."
alias mux="tmuxinator"

#Solarized Colors for ls and auto-completion
eval `dircolors ~/.dircolors`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
