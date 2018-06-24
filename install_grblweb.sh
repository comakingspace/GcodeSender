#!/bin/bash

echo 'We will install GRBLWeb now, which relies on NodeJS.'
git clone https://github.com/andrewhodel/grblweb.git /home/pi/grblweb
cd /home/pi/grblweb
npm install
cd ../GcodeSender
echo 'GRBLWeb was installed. configuring autostart now.'
cp grblwebconfig.js /home/pi/grblweb/config.js
sudo cp grblweb.service /etc/systemd/system/grblweb.service
sudo systemctl daemon-reload
sudo systemctl enable grblweb.service
sudo systemctl start grblweb
echo 'Autostart enabled, GRBLWeb installed...'