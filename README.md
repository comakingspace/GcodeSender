# GcodeSender
```bash
sudo apt-get update && sudo apt-get -qq install git && git clone https://github.com/comakingspace/GcodeSender.git && cd GcodeSender && ./install.sh
```
Please note this will currently install:  
NodeJS
CNCjs (port 8080)

Since the CNCjs Version we are using is a fork, it needs to be compiled first.
For this, The system will start an instance of screen during the installation in order to be able to keep running in case the SSH connection drops.
Cou can check the current status of the installation with 
```bash
screen -r CNCInstall for the current status
```
The installation will take quite a while.

Usage documentation can be found on  
https://wiki.comakingspace.de/G-Code_Sender
