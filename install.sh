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
GIT_USERNAME="ioExpander"
GIT_EMAIL="ioExpander@users.noreply.github.com"


#echo $BASEDIR
cd $BASEDIR
BASEDIR=$(pwd)

#Check Installed programs
for PROG in wget zsh vim tmux
do
	which $PROG >/dev/null || { echo "Please install $PROG"; exit 1; }
done

if [ ! -d ~/.oh-my-zsh ]; then
	#Temp fix as long as https://github.com/robbyrussell/oh-my-zsh/pull/5893 is not fixed
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {
	  echo "Could not install Oh My Zsh" >/dev/stderr
	  exit 1
	}
	#will not be needed when PR to enable batch installation is accepted !
	#echo "Oh My Zsh is not installed. Please run : "
	#echo "sh -c \"\$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)\""
	#exit 1
fi

#Install OhMyZshTheme
THEME_FILE="$HOME/.oh-my-zsh/custom/themes/pygmalion.zsh-theme"
mkdir -p $(dirname $THEME_FILE)
ln -fs $BASEDIR/pygmalion.zsh-theme $THEME_FILE

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
git config --global user.name $GIT_USERNAME
git config --global user.email $GIT_EMAIL

# Linking files
ln -fs $BASEDIR/tmux.conf ~/.tmux.conf
ln -fs $BASEDIR/vimrc ~/.vimrc

#Install Vundle plugins in vim
vim +PluginInstall +qall

#Copy Zshrc file
ln -fs $BASEDIR/zshrc ~/.zshrc

if [[ -d ~/.config/xfce4/terminal/ ]]; then
    ln -fs $BASEDIR/xfce4_terminalrc ~/.config/xfce4/terminal/terminalrc
fi

#install babun solarized theme if babun is detected
if [[ -e ~/.minttyrc ]]; then
    ln -fs $BASEDIR/minttyrc ~/.minttyrc
fi
