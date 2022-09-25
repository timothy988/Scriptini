#!/bin/bash
sudo echo " "
sudo mkdir /var/booksonic
sudo chmod 777 /var/booksonic/ -R
yay jre8-openjdk
sudo mkdir /var/booksonic/transcode/
sudo chmod 777 -R /var/booksonic/transcode/
cd /var/booksonic/transcode/
sudo ln -s /usr/bin/ffmpeg
sudo chown -h timothy:timothy ffmpeg
cd /home/timothy/Documents
wget https://github.com/popeen/Booksonic-Air/releases/download/v2112.2.0/booksonic.war
touch "java -jar booksonic.war -Dserver.port=8080"
exit
