#!/bin/bash
# ---------------------------------------------------------------------------
# mk2parts.sh - This script create a 3 partitions sd card for boot, rootfs and homefs. 

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

# Usage: mk2parts.sh /dev/device [-h|--help]

# Revision history:
# 2017-11-23 Created by script-gen.sh ver. 3.3
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

function ver() {
	printf "%03d%03d%03d" $(echo "$1" | tr '.' ' ')
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
  echo -e "Usage: $PROGNAME <device>"
}

help_message() {
  cat <<- _EOF_
  $PROGNAME ver. $VERSION
  This script create a 3 partitions sd card for boot, rootfs and homefs.

  $(usage)
  Example: $PROGNAME sdc

  Options:
  -h, --help  Display this help message and exit.
   
  NOTE: You must be the superuser to run this script.

_EOF_
  return
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
		  echo "arg1 is $1"
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

# new versions of sfdisk don't use rotating disk params
sfdisk_ver=`sfdisk --version | awk '{ print $4 }'`

if [ $(ver $sfdisk_ver) -lt $(ver 2.26.2) ]; then
	CYLINDERS=`echo $SIZE/255/63/512 | bc`
	echo "CYLINDERS – $CYLINDERS"
	SFDISK_CMD="sfdisk -D -H 255 -S 63 -C ${CYLINDERS}"
else
	SFDISK_CMD="sfdisk"
fi

echo -e "\nOkay, here we go ...\n"

echo -e "=== Zeroing the MBR ===\n"
dd if=/dev/zero of=$DRIVE bs=1024 count=1024

# 3 partitions
# Sectors are 512 bytes
# 0      : 64KB, no partition, MBR then empty
# 9    : 70 MB, FAT partition, bootloader 
# 200  : 1GB, linux partition, root filesystem
# 200  : 1GB+, linux partition, home filesystem

echo -e "\n=== Creating 3 partitions ===\n"
{
echo 0,9,0x0C,*
echo 9,134,0x83,-
echo ,,0x83,-
} | $SFDISK_CMD $DRIVE


echo "Partitioning Boot..."
if [ -b ${DRIVE}1 ]; then
	mkfs.vfat -F 32 -n "boot" ${DRIVE}1
else
	if [ -b ${DRIVE}p1 ]; then
		mkfs.vfat -F 32 -n "boot" ${DRIVE}p1
	else
		echo "cant find boot partition in /dev"
		graceful_exit
	fi
fi
echo "Done"

echo "Partitioning Rootfs..."
if [ -b ${DRIVE}2 ]; then
	mke2fs -j -L "rootfs" ${DRIVE}2
else
	if [ -b ${DRIVE}p2 ]; then
		mke2fs -j -L "rootfs" ${DRIVE}p2
	else
		echo "cant find rootfs partition in /dev"
		graceful_exit
	fi
fi
echo "Done"

echo "Partitioning Homefs..."
if [ -b ${DRIVE}3 ]; then
	mke2fs -j -L "homefs" ${DRIVE}3
else
	if [ -b ${DRIVE}p3 ]; then
		mke2fs -j -L "homefs" ${DRIVE}p3
	else
		echo "cant find homefs partition in /dev"
		graceful_exit
	fi
fi
echo "Done"
sync
sync

echo -e "\n=== Done! ===\n"
graceful_exit
