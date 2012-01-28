linuxcoin-setup
===============

A set of bash scripts and system files used to help setup Linuxcoin quickly.

These files go hand-in-hand with the [Setup a Bitcoin mining rig powered by Linuxcoin & Smartcoin](http://www.zulius.com/how-to/setup-bitcoin-mining-rig-powered-by-linuxcoin-smartcoin/) guide.


one-liners
==========
A few bash one-liners to run on your Linuxcoin rig to help automate setup.

### Setup persistence

    curl https://raw.github.com/timbowhite/linuxcoin-setup/master/setup/persistence.sh | bash 

What it does:

- setup ext4 file system persistence
- setup Linuxcoin to boot with perisistence by default (will overwrite syslinux.cfg)


### Make rig headless
    
    curl https://raw.github.com/timbowhite/linuxcoin-setup/master/setup/headless.sh | bash

What it does:

- apt-get update
- assigns a static IP (default is 192.168.0.150)
- makes the "user" user a password-less sudoer
- starts SSH
- enables SSH on boot


Contributing
============

Want to add something sweet? Here's what to do:

1. Fork this repository
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Send a pull request

Author
======

Timbo White of [Zulius](http://www.zulius.com).

Follow on the twit bullshit: [_zulius_](http://twitter.com/_zulius_)

License - GPL2
==============

Copyright (c) 2011 Zulius

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
