#!/bin/bash

sudo apt update

sudo apt install apache2 -y 
sudo ufw allow in "Apache"
sudo service apache2 start

sudo apt install openjdk-11-jdk -y

sudo timedatectl set-timezone Europe/Kiev


# change index.html
DATETIME=$(date)
cat > temp.html <<TXT
<html>
<body>
  <h1>$DATETIME</h1>
 </body>
</html>
TXT
sudo mv temp.html /var/www/html/index.html

#sudo apt upgrade -y






