Before scp

SSH Agent
Setup trought - Manage Credentials

OR!

1) We have to use -o StrictHostKeyChecking=no:
scp -v -o StrictHostKeyChecking=no index.html student@192.168.88.211
instead of:
scp -v index.html student@192.168.88.211:/var/www/html
2) We have to copy id_rsa to /var/lib/jenkins/.ssh
3)The /var/lib/jenkins/.ssh directory and filesinside of it should be owned by jenkins

chown jenkins:jenkins id_rsa
chmod 600 id_rsa


#=========================== Build=============

echo "======Build Started======"

cd m1/petclinic/
chmod +x ./mvnw
./mvnw package


ls -la

scp -o StrictHostKeyChecking=no target/*.jar ubuntu@172.31.22.175:/home/ubuntu/


echo "======Build Finished====="

#=======================================================


#================ Run jar as service ===================

echo "======Build Started======"


cat > petclinic.sh <<EOF
#!/bin/sh
java -jar /home/ubuntu/*.jar

EOF

chmod a+x petclinic.sh

cat > petclinic.service <<EOF
[Unit]
Description=Run petclinic.sh
[Service]
ExecStart=/home/ubuntu/petclinic.sh
[Install]
WantedBy=multi-user.target

EOF

cat > petclinicservice.sh <<EOF
# remove prev. service
sudo systemctl stop petclinic.service
sudo systemctl disable petclinic.service

# move service to dst dir
sudo mv petclinic.service /etc/systemd/system/

# start service
sudo systemctl daemon-reload
sudo systemctl enable petclinic.service
sudo systemctl start petclinic.service
sudo systemctl status petclinic.service

EOF

chmod a+x petclinicservice.sh

# copy new file to web server
scp -o StrictHostKeyChecking=no ./petclinic.* ubuntu@172.31.22.175:/home/ubuntu/
scp -o StrictHostKeyChecking=no petclinicservice.sh ubuntu@172.31.22.175:/home/ubuntu/
ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.175 ./petclinicservice.sh

echo "======Build Finished====="