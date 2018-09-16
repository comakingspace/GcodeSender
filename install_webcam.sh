sudo apt-get install cmake libjpeg8-dev
git clone https://github.com/jacksonliam/mjpg-streamer

cd mjpg-streamer-experimental
make
sudo make install
sudo cp mjpeg_streamer.service /etc/systemd/system/mjpeg_streamer.service
sudo systemctl daemon-reload
sudo systemctl enable mjpeg_streamer.service
sudo systemctl start mjpeg_streamer