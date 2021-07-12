#Use this only for profiling ZSH
#zmodload zsh/zprof


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load private settings... if found
if [ -f ~/.zshrc_privateSettings ]; then
    source ~/.zshrc_privateSettings
fi

#Fix wrong terminal colors when using tmux
#because xfce term do not have the right $TERM setting
if [ "$COLORTERM" = "gnome-terminal" -a "$TERM" = "xterm" ]; then
    export TERM=xterm-256color
fi
if [ "$COLORTERM" = "xfce4-terminal" -a "$TERM" = "xterm" ]; then
    export TERM=xterm-256color
fi

ENABLE_CORRECTION="true"       #enable correction of mistyped commands
COMPLETION_WAITING_DOTS="true" #display red dots whilst waiting for completion
#ANTIGEN new config back with oh-my-zsh
HIST_STAMPS="yyyy-mm-dd" # Format the output of history for oh-my-zsh
source ~/.antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle colored-man-pages
antigen bundle common-aliases
antigen bundle docker
antigen bundle git
antigen bundle kubectl
antigen bundle terraform
antigen bundle fasd # use j <FolderName> to jump or v FileName to edit
antigen bundle fd   # find replacement auto-completion
if [ -x "$(command -v fzf)" ]; then
    antigen bundle fzf # fuzzy auto complete (Ctrl - T for files) (Ctrl - R for history)
    # (cd xyz**<TAB> for fuzzy completion
fi
antigen bundle rand-quote # run 'quote'
antigen bundle rsync
antigen bundle sudo # add sudo in front of last CMD with ESC ESC combo
antigen bundle virtualenvwrapper
antigen bundle zsh_reload                              # reloads zsh config by running 'src'

antigen bundle sorin-ionescu/prezto modules/completion # because it's better than Oh-my-ZSH

#THEME
#antigen theme bhilburn/powerlevel9k powerlevel9k
antigen theme romkatv/powerlevel10k # much faster than powerlevel9K !
# Tip : run p10k configure to configure prompt with sensible defaults (after nerd font is on terminal)
#Others
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239'
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions              # Additional completion files
antigen bundle zsh-users/zsh-syntax-highlighting      #needs to be loaded before history-substring search
antigen bundle zsh-users/zsh-history-substring-search # search a substring in history with arrow keys

antigen apply
#Run 'antigen reset' and 'antigen cache-gen' after changes in antigen config
#Run 'antigen update' from time to time

## @Todo later :
# pipenv
# direnv a tool for sourcing env files in directories
# Scaleway autocomplete : https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/scw
# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/terraform

### User configuration

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# Add yarn global bin path to PATH
#if [ -x "$(command -v yarn)" ]; then
#    export PATH="$PATH:$(yarn global bin)"
#fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR="vim"

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases
alias tmux="tmux -2"
alias gwdiff="git diff --word-diff=color -b -w --ignore-blank-lines --ignore-space-at-eol"
alias gdiff="git diff --ignore-space-at-eol -b -w --ignore-blank-lines"

if ls --color=auto &> /dev/null
then
    alias ls="nocorrect ls --color=auto -F" #shows trailing / at the end of DirNames
else    
    #we are on MacOS
    export CLICOLOR=1
    alias ls="nocorrect ls -F"
fi
alias ll="ls -hl"
alias la="ls -hal"
alias l='nocorrect ls'

# ls alias if exa is found
if [ -x "$(command -v exa)" ]; then
    alias ll="exa -hl"
    alias la="exa -hal"
    alias l="exa"
fi

# Pacman aliases if detected
if [ -x "$(command -v pacman)" ]; then
    alias pacman='sudo pacman --color auto'
    alias upgrade='sudo pacman -Syyu --color auto'
    #Cleanup orphaned packages
    alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
    alias pac_clean='sudo paccache -rk 1' # don't forget to run this from time to time 
fi


# yay / AUR aliases if detected
if [ -x "$(command -v yay)" ]; then
    alias pksyua="yay -Syu --noconfirm" #Install skipping all questions
    alias yayskip='yay -S --mflags --skipinteg'
    alias trizenskip='trizen -S --skipinteg'
    alias upgrade='nocorrect yay -Syyu --noconfirm'
    alias pac_clean='sudo paccache -rk 1 && yay -Sc'
fi

#get fastest mirrors in your neighborhood 
if [ -x "$(command -v reflector)" ]; then
    alias mirror="sudo reflector -f 30 -l 30 --number 20 --verbose --save /etc/pacman.d/mirrorlist"
    alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
    alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
    alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
fi


# Grep aliases if rg is detected
if [ -x "$(command -v rg)" ]; then
    alias grep='nocorrect rg'
fi


# Less alias if most is detected
if [ -x "$(command -v most)" ]; then
    alias lest='nocorrect most'
fi

#git aliases
alias git_word-diff="git diff --color-words=."
alias mux="tmuxinator"

# Oh-my-zsh overrides the fd alias. Change to use the fd command if installed.
unalias fd
if [ ! -x "$(command -v fd)" ]; then
    alias fd='find . -type d -name'
fi

alias find='nocorrect find'
alias vim='nocorrect vim'

#disable autocorrect
unsetopt correct

#To make tilix happy
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

#Display neofetch on clear but not on terminal start
if command -v neofetch >/dev/null 2>&1; then
    alias clear="clear; neofetch --ascii_colors 4 --colors 4 1 1 4 1 fg"
    #neofetch disable on terminal start
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -x "$(command -v broot)" ]; then
    source /home/aditye/.config/broot/launcher/bash/br
fi

#Use for debugging startup time
#zprof

# Scaleway CLI autocomplete initialization.
if [ ! -x "$(command -v scw)" ]; then
    eval "$(scw autocomplete script shell=zsh)"
fi


