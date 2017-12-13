#!/bin/bash
# ---------------------------------------------------------------------------
# mk1part.sh - This script create 1 primary partition on the disk using all available space. 
#			   It purpse is to restore sd card default partition.

# Copyright 2017, kourouma,,, <kourouma@gmail.com>
  
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at <http://www.gnu.org/licenses/> for
# more details.

# Usage: mk1part.sh [-h|--help]

# Revision history:
# 2017-11-24 Created by script-gen.sh ver. 3.3
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
  echo -e "Usage: $PROGNAME [-h|--help] <device>"
}

help_message() {
  cat <<- _EOF_
  $PROGNAME ver. $VERSION
  This script create 1 primary partition on the disk using all available space. It purpse is to restore sd card default partition.

  $(usage)

  Options:
  -h, --help  Display this help message and exit.

  NOTE: You must be the superuser to run this script.

_EOF_
  return
}


do_partition() {
# This function creates one (1) primary partition on the
# disk, using all available space
   DISK=${1}
   echo "d
2
d
1
n
p
1


w"| fdisk "${DISK}" 
#> /dev/null 2>&1

#
# Use the bash-specific $PIPESTATUS to ensure we get the correct exit code
# from fdisk and not from echo
if [ ${PIPESTATUS[1]} -ne 0 ];
then
    echo "An error occurred partitioning ${DISK}" >&2
    echo "I cannot continue" >&2
    error_exit 2
fi
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
    -* | --*)
      usage
      error_exit "Unknown option $1" ;;
    *)
      echo "Argument $1 to process..." ;
	  if [ -n "$1" ]; then
		  DRIVE=/dev/$1

	  else
		  usage
		  graceful_exit
	  fi ;;
  esac
  shift
done

# Main logic
if [ ! -b $DRIVE ] ; then
	echo "$DRIVE: No such block device file found"
	graceful_exit
fi

if [ "$DRIVE" = "/dev/sda" ] ; then
	echo "Sorry, not going to format $DRIVE"
	graceful_exit
fi


echo -e "\nWorking on $DRIVE\n"

#make sure that the SD card isn't mounted before we start
for n in 1 2 3
do
	if [ -b ${DRIVE}${n} ]; then
		umount ${DRIVE}${n} 
	elif [ -b ${DRIVE}p${n} ]; then
		umount ${DRIVE}p${n}
	fi
done

if [ -b ${DRIVE} ]; then
	umount ${DRIVE}
fi

SIZE=`fdisk -l $DRIVE | grep "$DRIVE" | cut -d' ' -f5 | grep -o -E '[0-9]+'`

echo DISK SIZE – $SIZE bytes

if [ "$SIZE" -lt 1800000000 ]; then
	echo "Require an SD card of at least 2GB"
	graceful_exit
fi

if [ "$SIZE" -gt 17000000000 ]; then
	echo " Selected Device is greater than 16GB"
	graceful_exit
fi

do_partition ${DRIVE}
sync 
sync 

echo -e "\n=== Done! ===\n"

graceful_exit

