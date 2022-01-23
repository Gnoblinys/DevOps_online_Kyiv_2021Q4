#!/bin/bash

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
   /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install jenkins -y

sudo apt install openjdk-11-jdk -y

sudo systemctl daemon-reload
sudo systemctl start jenkins

sudo timedatectl set-timezone Europe/Kiev
sudo apt upgrade -y

