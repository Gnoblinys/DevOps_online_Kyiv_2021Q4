
#!/bin/bash

sudo apt update
sudo apt upgrade -y

sudo adduser web1 --disabled-password
sudo su web1
cd ~/
mkdir .ssh
chmod 700 .ssh
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys

ssh-keygen -m PEM -f ~/.ssh/web1 -N ""
cd .ssh/
mv web1 web1.pem





sudo apt install apache2 -y
sudo ufw allow in "Apache"






