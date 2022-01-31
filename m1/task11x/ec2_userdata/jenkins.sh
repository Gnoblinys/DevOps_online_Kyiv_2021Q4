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


 /etc/default/jenkins

sudo sed '9a\JAVA_ARGS="-Djenkins.install.runSetupWizard=false"' /etc/default/jenkins > temp.txt
sudo mv temp.txt /etc/default/jenkins

sudo mkdir /var/lib/jenkins/init.groovy.d

sudo cat > /var/lib/jenkins/init.groovy.d/basic-security.groovy <<TXT

#!groovy

import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin","1111")
instance.setSecurityRealm(hudsonRealm)


def strategy = new hudson.security.FullControlOnceLoggedInAuthorizationStrategy()
strategy.add(Jenkins.ADMINISTER, admin)
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)


instance.save()

TXT

sudo service jenkins stop
sudo service jenkins start

#sudo rm /var/lib/jenkins/init.groovy.d/basic-security.groovy

sudo timedatectl set-timezone Europe/Kiev
#sudo apt upgrade -y


