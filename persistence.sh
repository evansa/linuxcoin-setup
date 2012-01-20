#!/bin/bash

<<HEAD

Name:           bashtasklog.sh
Company:        Zulius
Author:         Timbo White
Website:        http://www.zulius.com
Description:    Bash script for setting up Linuxcoin persistence on a USB device. 
Copyright:      2012 Zulius
License:        GPL v2 (http://www.gnu.org/licenses/gpl-2.0.html)

HEAD

# bashtasklog for pretty output
BTL_SRC="https://raw.github.com/timbowhite/bashtasklog/master/bashtasklog.sh"
BTL_DST="/tmp/bashtasklog.sh"

# pre-madesyslinux.cfg
SYSLINUX_SRC="https://raw.github.com/timbowhite/linuxcoin-setup/master/syslinux.cfg"
SYSLINUX_DST="/live/image/syslinux.cfg"

# persistence partition
PERS_PART="/dev/sda2"

echo "Downloading bashtasklog lib from github (for nice output)..."
OUTPUT=$(wget "$BTL_SRC" -O "$BTL_DST" 2>&1)
RET_VAL=$?
if [ "$RET_VAL" != 0 ] || [ ! -f "$BTL_DST" ]; then
  echo "Failed to download $BTL_SRC, wget output:\n\n${OUTPUT}"
  exit 1
fi

source "$BTL_DST"
new bashtasklog logger 
logger.printTask "Looking for $PERS_PART mountpoint"
PERS_MP=$(df | grep "$PERS_PART" | tr -s ' ' | cut -d' ' -f6)

if [ -z $PERS_MP ]; then
  logger.printFail "Failed to get mountpoint for $PERS_PART"
  exit 1
fi

logger.printOk

logger.printTask "Mountpoint is $PERS_MP, unmounting"
OUTPUT=$(umount "$PERS_MP" 2>&1)
RET_VAL=$?
if [ "$RET_VAL" != 0 ]; then
  logger.printFail "Failed to unmount $PERS_PART, output:\n\n${OUTPUT}"
  exit 1
fi
logger.printOk

logger.printTask "Creating ext4 file system at $PERS_PART" 
OUTPUT=$(mkfs.ext4 "$PERS_PART" -L live-rw 2>&1)
RET_VAL=$?
if [ "$RET_VAL" != 0 ]; then
  logger.printFail "Failed to unmount $PERS_PART, output:\n\n${OUTPUT}"
  exit 1
fi
logger.printOk

logger.printTask "Downloading syslinux.cfg to $SYSLINUX_DST"
OUTPUT=$(wget "$SYSLINUX_SRC" -O "$SYSLINUX_DST" 2>&1)
RET_VAL=$?
if [ "$RET_VAL" != 0 ]; then
  logger.printFail "Failed, output:\n\n${OUTPUT}"
  exit 1
fi
logger.printOk


logger.printTask "Rebooting in 5 seconds, CTRL-C to cancel..."
sleep 5
shutdown -r now
logger.printOk
logger.printTask "Rebooting..."
logger.printOk
