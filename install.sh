#!/bin/bash

echo 'please do not run this as root'
sudo ./install_systemsettings.sh
sudo ./install_nicetohavesoftware.sh
sudo ./install_node.sh
./install_laserweb4.sh
./install_cncjs.sh
./install_grblweb.sh
echo 'All done, it would be a great idea to reboot now.'