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
Description=Run petclinick.sh
[Service]
ExecStart=/home/ubuntu/petclinic.sh
[Install]
WantedBy=multi-user.target

EOF

# remove prev. service
ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.175 sudo systemctl stop petclinic.service
ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.175 sudo systemctl disable petclinic.service

# copy new file to web server
scp -o StrictHostKeyChecking=no petclinic.sh ubuntu@172.31.22.175:/home/ubuntu/
scp -o StrictHostKeyChecking=no petclinic.service ubuntu@172.31.22.175:/home/ubuntu/

# move service to dst dir
ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.175 sudo mv petclinic.service /etc/systemd/system/

# start service
ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.175 sudo systemctl daemon-reload
ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.175 sudo systemctl enable petclinic.service
ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.175 sudo systemctl start petclinic.service
ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.175 sudo systemctl status petclinic.service


echo "======Build Finished====="