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


if [ $BASEDIR = '.' ]
then
	BASEDIR=$(pwd)
fi


# Linking files
ln -fs $BASEDIR/tmux.conf ~/.tmux.conf
ln -fs $BASEDIR/vimrc ~/.vimrc
ln -fs $BASEDIR/zshrc ~/.zshrc

