#!/bin/bash

echo 'We will install laserweb4 now, which relies on NodeJS.'
git clone https://github.com/LaserWeb/lw.comm-server.git
cd lw.comm-server
sudo npm install serialport --unsafe-perm --build-from-source --quiet
sudo npm install --quiet
echo 'LaserWeb was installed. configuring autostart now.'
sudo cp /home/pi/lw.comm-server/lw.comm-server.service /etc/systemd/system/lw.comm-server.service
sudo systemctl daemon-reload
sudo systemctl enable lw.comm-server.service
sudo systemctl start lw.comm-server
echo 'Autostart enabled, LaserWeb installed...'