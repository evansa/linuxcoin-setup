#!/bin/bash

<<HEAD

Name:           lockup.sh 
Company:        Zulius
Author:         Timbo White
Website:        http://www.zulius.com
Description:    Smartcoin script that gets executed after a GPU lockup event.
                Here's what it does: 
                - sends a notification email with current system stats 
                - reboots the mining rig
Copyright:      2011 Zulius
License:        GPL v2 (http://www.gnu.org/licenses/gpl-2.0.html)
Where to put:   /opt/smartcoin/lockup.sh

HEAD

### config section ### 

TO_EMAIL="your@email.com";
FROM_EMAIL="from@email.com";
SUBJECT="GPU lockup detected";
GPU_TEMP=`sudo aticonfig --adapter=all --odgt`
GPU_CLOCKS=`sudo aticonfig --adapter=all --odgc`
TOP=`sudo top -b -c -n 1`
### /config section ###

DATE=$(date)

# compose email
EMAIL=$(cat <<EOF
From: $FROM_EMAIL
To: $TO_EMAIL
Subject: $SUBJECT

GPU lockup at $DATE

..:: GPU temperatures ::..
$GPU_TEMP

..:: GPU clocks ::..
$GPU_CLOCKS

..:: top ::..
$TOP


EOF
)

cat "$EMAIL"|sendmail -t;

# wait a few seconds to flush email queue
# and shutdown
sleep 5
shutdown -fr now
