#!/bin/bash

#install packages
install_package() {
	dpkg -s $1 &> /dev/null
	if [ $? -ne 0 ]; then
		apt-get update -y
		apt-get install $1 -y
	fi
}

install_package git
install_package curl
install_package zsh

# Check if vim Plug is installed
if [ ! -f "~/.vim/autoload/plug.vim" ]; then
	echo 'Installing vim plug'
	sh -c "$(curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)"
else
	echo 'vim plug installed'
fi

# Check if oh-my-zsh is installed
OMZDIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZDIR" ]; then
  echo 'Installing oh-my-zsh'
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
else
  echo 'Updating oh-my-zsh'
  upgrade_oh_my_zsh
fi

# Change default shell
if [! $0 = "-zsh"]; then
  echo 'Changing default shell to zsh'
  chsh -s /bin/zsh
else
  echo 'Already using zsh'
fi
