#!/bin/bash

echo 'Now we will install cncjs'
sudo npm install -g cncjs@latest --quiet
sudo cp cncjs.service /etc/systemd/system/cncjs.service
sudo systemctl daemon-reload
sudo systemctl enable cncjs.service
sudo systemctl start cncjs
echo 'Autostart enabled, cncjs installed...'