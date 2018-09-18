#!/bin/bash

echo 'Now we will install  our custom version of cncjs'

echo 'First we have to enlarge the swap file.'

# Edit /etc/dphys-swapfile
sudo cp dphys-swapfile_3GB /etc/dphys-swapfile
sudo systemctl stop dphys-swapfile.service
sudo systemctl start dphys-swapfile.service

#now we can install cncjs
cd ..
git clone https://github.com/comakingspace/cncjs/
cd cncjs
npm install -g npm@5.6.0
npm install --build-from-source
cd ../GcodeSender
sudo cp cncjs_custom.service /etc/systemd/system/cncjs_custom.service
cp cncrc_settings.json ~/.cncrc
sudo systemctl daemon-reload
sudo systemctl enable cncjs_custom.service
sudo systemctl start cncjs_custom
echo 'Autostart enabled, custom cncjs installed...'