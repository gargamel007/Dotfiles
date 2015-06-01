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
echo "please run git config --global user.name USERNAME"
echo "please run git config --global user.email EMAIL"
git config --global credential.helper cache
git config --global credential.helper "cache --timeout=7200"
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto



# Linking files
ln -fs $BASEDIR/tmux.conf ~/.tmux.conf
ln -fs $BASEDIR/vimrc ~/.vimrc
ln -fs $BASEDIR/zshrc ~/.zshrc

#Install Vundle plugins in vim
vim +PluginInstall +qall
