#!/bin/sh

enter_full_setting()
{
lua - "$1" "$2" <<EOF > "$2.bak"
local key=assert(arg[1])
local fn=assert(arg[2])
local file=assert(io.open(fn))
local made_change=False
for line in file:lines() do
  if line:match("^#?%s*"..key) then
    line=key
    made_change=True
  end
  print(line)
end
if not made_change then
  print(key)
end
EOF
mv "$2.bak" "$2"
}

enable_wifi_ap()
{
#This might be needed in a later version, in case we decide the pi should open a Wifi AP.
sudo apt-get -qq -y  install dnsmasq hostapd >> /dev/null
NOW=$(date +"%m_%d_%Y")
sudo cp /etc/dhcpcd.conf /etc/dhcpcd_$NOW.conf.bak
sudo echo "interface wlan0" > /etc/dhcpcd.conf
sudo echo "static ip_address=10.0.0.1/24" >> /etc/dhcpcd.conf
sudo service dhcpcd restart
sudo cp /etc/dnsmasq.conf /etc/dnsmasq_$NOW.conf.bak  
sudo echo "interface=wlan0" > /etc/dnsmasq.conf
sudo echo "dhcp-range=10.0.0.1,10.0.0.255,255.255.255.0,24h" >> /etc/dnsmasq.conf

sudo echo "interface=wlan0" > /etc/hostapd/hostapd.conf
#sudo echo "driver=rtl8192cu" >> /etc/hostapd/hostapd.conf
sudo echo "ssid=PiMusicbox" >> /etc/hostapd/hostapd.conf
sudo echo "hw_mode=g" >> /etc/hostapd/hostapd.conf
sudo echo "channel=6" >> /etc/hostapd/hostapd.conf
sudo echo "macaddr_acl=0" >> /etc/hostapd/hostapd.conf
sudo echo "auth_algs=1" >> /etc/hostapd/hostapd.conf
sudo echo "ignore_broadcast_ssid=0" >> /etc/hostapd/hostapd.conf
sudo echo "wpa=2" >> /etc/hostapd/hostapd.conf
sudo echo "wpa_passphrase=12345678" >> /etc/hostapd/hostapd.conf
sudo echo "wpa_key_mgmt=WPA-PSK" >> /etc/hostapd/hostapd.conf
sudo echo "wpa_pairwise=TKIP" >> /etc/hostapd/hostapd.conf
sudo echo "rsn_pairwise=CCMP" >> /etc/hostapd/hostapd.conf

sudo cp /etc/default/hostapd /etc/default/hostapd_$NOW.bak  
sudo echo "DAEMON_CONF=\"/etc/hostapd/hostapd.conf\"" > /etc/default/hostapd

sudo systemctl start hostapd
sudo systemctl start dnsmasq
}


echo '--------------------------------------------'
echo 'First, we need to do some basic settings...'
echo 'Expand the FS'
sudo raspi-config nonint do_expand_rootfs >> /dev/null
echo 'boot to command line'
sudo raspi-config nonint do_boot_behaviour B1
echo 'Change the hostname'
sudo raspi-config nonint do_hostname CoMakingCNC

echo '--------------------------------------------'
echo 'just in case we are running on a RPi 3 with wifi enabled, we will do some settings in order to ensure good ssh performance'
enter_full_setting 'IPQoS 0x00' /etc/ssh/ssh_config
enter_full_setting 'IPQoS 0x00' /etc/ssh/sshd_config
sudo systemctl restart ssh

echo '--------------------------------------------'
echo 'System Settings changed, a reboot is recommended.'