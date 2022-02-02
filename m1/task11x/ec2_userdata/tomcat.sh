#!/bin/bash
# https://www.digitalocean.com/community/tutorials/install-tomcat-9-ubuntu-1804-ru

sudo apt update
sudo apt install default-jdk -y

# add user tomcat
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat # /bin/false without ability login in user

# install Tomcat
cd /tmp
curl -O https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.16/bin/apache-tomcat-10.0.16.tar.gz

sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-*tar.gz -C /opt/tomcat --strip-components=1


cd /opt/tomcat
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/

# ctreate tomkte as service

sudo update-java-alternatives -l # finde where is java

sudo nano /etc/systemd/system/tomcat.service

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl status tomcat

sudo ufw allow 8080

#enable auto start
sudo systemctl enable tomcat


#setup admin user for tomcat
sudo nano /opt/tomcat/conf/tomcat-users.xml


#you can use environment variable ???

<user username="admin" password="admin" roles="manager-gui,admin-gui"/>


# fore acces from anything ip 
#comment this lines:
#  <!--<Valve className="org.apache.catalina.valves.RemoteAddrValve"
#        allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />-->

sudo nano /opt/tomcat/webapps/manager/META-INF/context.xml
sudo nano /opt/tomcat/webapps/host-manager/META-INF/context.xml
sudo systemctl restart tomcat

#install maven
sudo apt install -y maven


