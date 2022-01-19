
#!/bin/bash

sudo timedatectl set-timezone Europe/Kiev

sudo apt update
sudo apt upgrade -y

sudo apt install apache2 -y
sudo ufw allow in "Apache"




#ssh
sudo adduser web1 --disabled-password
sudo su web1
cd ~/
mkdir .ssh
chmod 700 .ssh
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys

In clietn - ssh-keygen -t rsa -m PEM -f webkey -N ""

!!!!!! key.pub write to authorized_keys in target server!













