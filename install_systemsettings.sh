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


echo '--------------------------------------------'
echo 'First, we need to do some basic settings...'
echo 'Expand the FS'
sudo raspi-config nonint do_expand_rootfs >> /dev/null
echo 'boot to command line'
sudo raspi-config nonint do_boot_behaviour B1
echo 'Change the hostname'
sudo raspi-config nonint do_hostname CoMakingCNC

echo 'writing python listener for power button'
sudo mkdir /opt/powerbutton
sudo cp listen-for-shutdown.py /opt/powerbutton/listen-for-shutdown.py

echo 'writing systemd service for power button'
sudo cp listen-for-shutdown.service /etc/systemd/system/listen-for-shutdown.service
sudo systemctl enable listen-for-shutdown.service
sudo systemctl start listen-for-shutdown.service

echo '--------------------------------------------'
echo 'just in case we are running on a RPi 3 with wifi enabled, we will do some settings in order to ensure good ssh performance'
enter_full_setting 'IPQoS 0x00' /etc/ssh/ssh_config
enter_full_setting 'IPQoS 0x00' /etc/ssh/sshd_config
sudo systemctl restart ssh

echo '--------------------------------------------'
echo 'System Settings changed, a reboot is recommended.'