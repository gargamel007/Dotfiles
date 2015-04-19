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
wget -P /tmp/ --no-check-certificate https://github.com/seebi/tmux-colors-solarized/blob/master/tmuxcolors-256.conf
mv -f /tmp/tmuxcolors-256.conf ~/.tmuxcolors-256.conf

# Linking files
ln -fs $BASEDIR/tmux.conf ~/.tmux.conf
ln -fs $BASEDIR/vimrc ~/.vimrc
ln -fs $BASEDIR/zshrc ~/.zshrc

#Install Vundle plugins in vim
vim +PluginInstall +qall
