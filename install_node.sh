#!/bin/bash

echo 'welcome to our installation script for node.js'
echo 'We will install the lastest LTS version of node using an installation script provided by sdesales'
sudo apt-get -qq update
wget https://raw.githubusercontent.com/sdesalas/node-pi-zero/master/install-node-v.lts.sh 
chmod +x install-node-v.lts.sh 
./install-node-v.lts.sh
echo 'node was installed with the following versions:'
echo 'node:'
echo node -v
echo 'npm:'
echo npm -v
