#!/bin/bash

echo 'Now we will install cncjs'

#This works:
sudo npm install -g cncjs@latest --unsafe-perm --quiet # Seems to work
sudo cp cncjs.service /etc/systemd/system/cncjs.service
sudo systemctl daemon-reload
sudo systemctl enable cncjs.service
sudo systemctl start cncjs
echo 'Autostart enabled, cncjs installed...'