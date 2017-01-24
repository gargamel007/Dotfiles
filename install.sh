#!/bin/bash

###########################
#Doc & Usage
###########################
:<<'USAGE'
@TODO
USAGE

###########################
#Configuration
###########################
BASEDIR=$(dirname $0)
BACKUPDIR="~/.dotfilesbak"

echo $BASEDIR
cd $BASEDIR
BASEDIR=$(pwd)

#Install solarized colors for ls
wget -P /tmp/ --no-check-certificate https://raw.github.com/seebi/dircolors-solarized/master/dircolors.ansi-dark
mv -f /tmp/dircolors.ansi-dark ~/.dircolors
eval `dircolors ~/.dircolors`

#Install solarized colors for tmux
#Testing the dark setting with better colors
#wget -P /tmp/ --no-check-certificate https://raw.githubusercontent.com/seebi/tmux-colors-solarized/master/tmuxcolors-256.conf
#mv -f /tmp/tmuxcolors-256.conf ~/.tmuxcolors-custom.conf
wget -P /tmp/ --no-check-certificate https://raw.githubusercontent.com/seebi/tmux-colors-solarized/master/tmuxcolors-dark.conf
mv -f /tmp/tmuxcolors-dark.conf ~/.tmuxcolors-custom.conf

# configure git
git config --global color.ui true
git config --global credential.helper cache
git config --global credential.helper "cache --timeout=7200"
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global user.name ioExpander
git config --global user.email ioExpander@users.noreply.github.com

# Linking files
ln -fs $BASEDIR/tmux.conf ~/.tmux.conf
ln -fs $BASEDIR/vimrc ~/.vimrc
#Install Vundle plugins in vim
vim +PluginInstall +qall

ln -fs $BASEDIR/zshrc ~/.zshrc
if [[ -d ~/.config/xfce4/terminal/ ]]; then
    ln -fs $BASEDIR/xfce4_terminalrc ~/.config/xfce4/terminal/terminalrc
fi


#install babun solarized theme if babun is detected
if [[ -e ~/.minttyrc ]]; then
    ln -fs $BASEDIR/minttyrc ~/.minttyrc
fi

echo "please run sh -c \"\$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)\""
