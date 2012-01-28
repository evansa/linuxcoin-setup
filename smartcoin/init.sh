#!/bin/bash

<<HEAD

Name:           lockup.sh
Company:        Zulius
Author:         Timbo White
Website:        http://www.zulius.com
Description:    Smartcoin script that gets executed when Smartcon is started.
                Here's what it does:
                - sets the fan speed percentage of the graphics card
Copyright:      2011 Zulius
License:        GPL v2 (http://www.gnu.org/licenses/gpl-2.0.html)
Where to put:   /opt/smartcoin/lockup.sh

HEAD

### config section ###
FANSPEED_PERCENTAGE="80"
### /config section ###

# set the fan speed percentage for the 1st graphics card
DISPLAY=:0.0 aticonfig --pplib-cmd "set fanspeed 0 $FANSPEED_PERCENTAGE"

# Add other fan controls for separate cards.
# If the first card has only 1 GPU, increment the DISPLAY variable by 1 
# to set the fan on the 2nd card:

# DISPLAY=:0.2 aticonfig --pplib-cmd "set fanspeed 0 {$FANSPEED_PERCENTAGE}"

# If the first card has 2 GPU's, increment the DISPLAY variable by 2
# to set the fan on the 2nd card:

# DISPLAY=:0.2 aticonfig --pplib-cmd "set fanspeed 0 {$FANSPEED_PERCENTAGE}"
