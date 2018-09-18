#!/bin/bash

echo 'please do not run this as root'
sudo ./install_systemsettings.sh
sudo ./install_nicetohavesoftware.sh

screen -dmS CNCInstall bash -c 'sudo ./install_node.sh; ./install_cncjs_custom.sh; ./install_webcam.sh; exec bash'
# sudo ./install_node.sh
# #./install_laserweb4.sh
# #./install_cncjs.sh
# ./install_cncjs_custom.sh
# #./install_grblweb.sh
# ./install_webcam.sh
echo 'All done, it would be a great idea to reboot now.'