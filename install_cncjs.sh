#!/bin/bash

echo 'Now we will install cncjs'

#This works:
sudo npm install serialport --unsafe-perm --build-from-source --quiet
sudo npm install -g cncjs@latest --unsafe-perm --quiet # Seems to work
sudo cp cncjs.service /etc/systemd/system/cncjs.service
cp cncrc_settings.json ~/.cncrc
sudo systemctl daemon-reload
sudo systemctl enable cncjs.service
sudo systemctl start cncjs
echo 'Autostart enabled, cncjs installed...'