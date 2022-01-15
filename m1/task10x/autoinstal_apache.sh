
#!/bin/bash

sudo apt update
sudo apt upgrade -y

sudo useradd -m web1
sudo mkdir /home/web1/.ssh
sudo chmod 700 /home/web1/.ssh
sudo touch /home/web1/.ssh/authorized_keys
sudo chmod 600 /home/web1/.ssh/authorized_keys



sudo apt install apache2 -y
sudo ufw allow in "Apache"






