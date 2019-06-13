#!/bin/bash

###########################
#Doc & Usage
###########################
: <<'USAGE'
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
for PROG in wget zsh vim tmux; do
    which $PROG >/dev/null || {
        echo "Please install $PROG"
        exit 1
    }
done

#Initiate private zshconfig file with current user name
if [ ! -f ~/.zshrc_privateSettings ]; then
    echo "DEFAULT_USER=$(whoami)" >~/.zshrc_privateSettings
fi

#Install Antigen plugin manager for zsh
mkdir -p ~/.antigen/
git clone https://github.com/zsh-users/antigen.git ~/.antigen

#Intall TMux plugin manager
if [ ! -d "~/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

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

#XFCE TERMINAL CONFIG
#if [[ -d ~/.config/xfce4/terminal/ ]]; then
#    ln -fs $BASEDIR/xfce4_terminalrc ~/.config/xfce4/terminal/terminalrc
#fi
#Get some color schemes for xfceterminal
wget -P /tmp/ --no-check-certificate https://raw.githubusercontent.com/afg984/base16-xfce4-terminal/master/colorschemes/base16-monokai.16.theme
wget -P /tmp/ --no-check-certificate https://raw.githubusercontent.com/afg984/base16-xfce4-terminal/master/colorschemes/base16-monokai.theme
wget -P /tmp/ --no-check-certificate https://raw.githubusercontent.com/afg984/base16-xfce4-terminal/master/colorschemes/base16-onedark.16.theme
wget -P /tmp/ --no-check-certificate https://raw.githubusercontent.com/afg984/base16-xfce4-terminal/master/colorschemes/base16-onedark.theme
wget -P /tmp/ --no-check-certificate https://raw.githubusercontent.com/afg984/base16-xfce4-terminal/master/colorschemes/base16-solarized-dark.theme
wget -P /tmp/ --no-check-certificate https://raw.githubusercontent.com/afg984/base16-xfce4-terminal/master/colorschemes/base16-solarized-dark.16.theme

mkdir --parents ~/.local/share/xfce4/terminal/colorschemes/
mv -f /tmp/*.theme $_
