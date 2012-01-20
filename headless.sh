#!/bin/bash

<<HEAD

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
RCLOCAL_SRC="https://raw.github.com/timbowhite/linuxcoin-setup/master/rc.local"
RCLOCAL_DST="/etc/rc.local"

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
rm -f "$BTL_DST"

new bashtasklog logger -w 60 
logger.printTask "Running apt-get update"
logger.printOk
apt-get update

logger.printTask "Appending static IP address assignment to $RCLOCAL_DST"
OUTPUT=$(curl "$RCLOCAL_SRC" >> "$RCLOCAL_DST")
RET_VAL=$?
if [ "$RET_VAL" != 0 ]; then
  logger.printFail "Failed, output:\n\n${OUTPUT}"
  exit 1
fi
logger.printOk

logger.printTask "Making user a password-less sudoer"
echo "user ALL = NOPASSWD : ALL" >> /etc/sudoers
logger.printOk

logger.printTask "Starting SSH"
logger.printOk
/etc/init.d/ssh start

logger.printTask "Enabling SSH daemon on boot"
logger.printOk
update-rc.d ssh enable

echo "NOTE: Make sure to edit /etc/rc.local with your static IP address and network settings."
echo "When that's done, run the following command:\n"
echo "/etc/rc.local && /etc/init.d/networking restart"
