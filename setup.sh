#!/bin/bash
# ---------------------------------------------------------------------------
# setup.sh - setup install env config scripts and utilities. It is an interactive script an

# Copyright 2017, kourouma,,, <kourouma@DebianDevOs>
  
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at <http://www.gnu.org/licenses/> for
# more details.

# Usage: setup.sh [-h|--help] [-f|--force]

# Revision history:
# 2017-12-13 Created by script-gen.sh ver. 3.3
# ---------------------------------------------------------------------------

PROGNAME=${0##*/}
VERSION="0.1"
dir_env="$PWD/env"
dir_elnx="$PWD/elnx"
user=${SUDO_USER:-$(whoami)}
HOME_BASHRC="/home/$user/.bashrc"
RT_BASHRC="/root/.bashrc"
src_cfg_file="source $PWD/configs.sh"
clean_up() { # Perform pre-exit housekeeping
  return
}

error_exit() {
  echo -e "${PROGNAME}: ${1:-"Unknown Error"}" >&2
  clean_up
  exit 1
}

graceful_exit() {
  clean_up
  exit
}

signal_exit() { # Handle trapped signals
  case $1 in
    INT)
      error_exit "Program interrupted by user" ;;
    TERM)
      echo -e "\n$PROGNAME: Program terminated" >&2
      graceful_exit ;;
    *)
      error_exit "$PROGNAME: Terminating on unknown signal" ;;
  esac
}

usage() {
  echo -e "Usage: $PROGNAME [-h|--help] [-f|--force]"
}

help_message() {
  cat <<- _EOF_
  $PROGNAME ver. $VERSION
  setup install env config scripts and utilities. It is an interactive script an

  $(usage)

  Options:
  -h, --help  Display this help message and exit.
  -f, --force  install all features without interaction

  NOTE: You must be the superuser to run this script.

_EOF_
  return
}

bashrc_install() {

	if ! grep -Fq "$1" "$2";
	then
		echo $1 >> $2
		echo "$2: updated"
	else
		echo "${1#* }: installed realoading..." 
	fi
}


bin_file_inst() {
	echo "installing ${1##*/} files..."
	for fl in $1/*; do 
		fname=${fl##*/}
		if [ -f $fl ]; then
			if [ ! -f $PWD/bin/${fname%.sh} ]; then
				ln -s $fl $PWD/bin/${fname%.sh}
			fi
		fi
	done
}

bin_folder_inst() {
# assuming only 1 level of nested folders adopted
echo "installing $1 subfolders..."
	for fl in $1/*; do 
		if [ -d $fl ]; then
			bin_file_inst $fl
		fi
	done
}

# Trap signals
trap "signal_exit TERM" TERM HUP
trap "signal_exit INT"  INT

# Check for root UID
if [[ $(id -u) != 0 ]]; then
  error_exit "You must be the superuser to run this script."
fi

# Parse command-line
while [[ -n $1 ]]; do
  case $1 in
    -h | --help)
      help_message; graceful_exit ;;
    -f | --force)
      echo "install all features without interaction" ;;
#	  NOINTERACT=1;;
    -* | --*)
      usage
      error_exit "Unknown option $1" ;;
  esac
  shift
done

# Main logic

if [ ! -d "$PWD/bin" ]; then
	mkdir "$PWD/bin"
fi

# install bin files ...
if ! grep -Fq -- "export PATH=$PWD/bin:\$PATH" configs.sh; then

	echo "installing bin files ..."
	echo "export PATH=$PWD/bin:\$PATH" >> configs.sh
else
	echo "bin files already installed."
fi

# install env files
echo "installing env files..."
if ! grep -Fq -- "for fl in $PWD/env/*; do source \$fl; done" configs.sh; then
	echo "for fl in $PWD/env/*; do source \$fl; done" >> configs.sh
fi

# install embedded linux utils scripts
bin_folder_inst "$PWD/elnx"
bin_file_inst "$PWD/elnx"

# install utilities scripts
bin_folder_inst "$PWD/utils"
bin_file_inst "$PWD/utils"

# install tools configuration scripts
bin_folder_inst "$PWD/tools"
bin_file_inst "$PWD/tools"

# vim environment install

# tmux env install

echo "installing configs in bashrc files..."
bashrc_install "$src_cfg_file" "$HOME_BASHRC"
source $HOME_BASHRC
bashrc_install "$src_cfg_file" "$RT_BASHRC"
source $RT_BASHRC

graceful_exit

