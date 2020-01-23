#!/bin/bash
# ---------------------------------------------------------------------------
# configs.sh -

# Copyright 2018, kourouma,,, <kourouma@DebianDevOs>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at <http://www.gnu.org/licenses/> for
# more details.

# Usage: configs.sh [-h|--help]

# Revision history:
# 2018-01-05 Created by script-gen.sh ver. 3.3
# ---------------------------------------------------------------------------

PROGNAME=${0##*/}
VERSION="0.1"

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
  echo -e "Usage: $PROGNAME [-h|--help]"
}

help_message() {
  cat <<- _EOF_
  $PROGNAME ver. $VERSION


  $(usage)

  Options:
  -h, --help  Display this help message and exit.

_EOF_
  return
}

# Trap signals
#trap "signal_exit TERM" TERM HUP
#trap "signal_exit INT"  INT



# Parse command-line
while [[ -n $1 ]]; do
  case $1 in
    -h | --help)
      help_message; graceful_exit ;;
    -* | --*)
      usage
      error_exit "Unknown option $1" ;;
    *)
      echo "Argument $1 to process..." ;;
  esac
  shift
done

# Main logic

#graceful_exit

export PATH=/home/kourouma/.setup/env-configs/bin:$PATH
export PATH=/usr/local/texlive/2017/bin/x86_64-linux:$PATH
#export MANPATH=/home/kourouma/.setup/env-configs/bin:$PATH
for fl in /home/kourouma/.setup/env-configs/env/*; do source $fl; done


