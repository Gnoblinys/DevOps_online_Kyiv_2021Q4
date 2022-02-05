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

scp -o StrictHostKeyChecking=no petclinic.sh ubuntu@172.31.22.175:/home/ubuntu/
scp -o StrictHostKeyChecking=no petclinic.service ubuntu@172.31.22.175:/home/ubuntu/


ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.175 sudo mv petclinic.service /etc/systemd/system/

ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.175 sudo systemctl daemon-reload
ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.175 sudo systemctl enable petclinic.service
ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.175 sudo systemctl start petclinic.service
ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.175 sudo systemctl status petclinic.service


echo "======Build Finished====="
