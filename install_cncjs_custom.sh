#!/bin/bash

echo 'Now we will install  our custom version of cncjs'

echo 'First we have to enlarge the swap file.'

# Edit /etc/dphys-swapfile
sudo cp dphys-swapfile_3GB /etc/dphys-swapfile
sudo systemctl stop dphys-swapfile.service
sudo systemctl start dphys-swapfile.service

echo 'Now we can clone and build out CNCjs fork'
cd ..
git clone https://github.com/comakingspace/cncjs/
cd cncjs
npm install -g npm@5.6.0
npm install --build-from-source
cd ../GcodeSender

echo 'Revert the swapfile changes...'
sudo cp dphys-swapfile_100MB /etc/dphys-swapfile
sudo systemctl stop dphys-swapfile.service
sudo systemctl start dphys-swapfile.service

echo 'And finally start the service.'
sudo cp cncjs_custom.service /etc/systemd/system/cncjs_custom.service
cp cncrc_settings.json ~/.cncrc
sudo systemctl daemon-reload
sudo systemctl enable cncjs_custom.service
sudo systemctl start cncjs_custom
echo 'Autostart enabled, custom cncjs installed...'

echo 'installing the cnc panel'
cd ..
git clone https://github.com/comakingspace/cnc-panel
cd cnc-panel
sudo cp cnc_panel.service /etc/systemd/system/cnc_panel.service
sudo systemctl daemon-reload
sudo systemctl enable cncjs_custom.service
sudo systemctl start cncjs_custom
echo 'cnc panel installed and activated'
