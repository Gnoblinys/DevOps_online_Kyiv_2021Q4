Before scp

1) We have to use -o StrictHostKeyChecking=no:
scp -v -o StrictHostKeyChecking=no index.html student@192.168.88.211:/var/www/html
instead of:
scp -v index.html student@192.168.88.211:/var/www/html
2) We have to copy id_rsa to /var/lib/jenkins/.ssh
3)The /var/lib/jenkins/.ssh directory and filesinside of it should be owned by jenkins

chown jenkins:jenkins id_rsa
chmod 600 id_rsa


echo "======Build Started======"
cat <<EOF > index.html
<html>
<body bgcolor=black>
<center>
<h2><font color=yellow>Test Jankins Build</font></h2>
<h2><font color=yellow>Changed 1</font></h2>
</center>
</body>
</html>>
EOF
scp -i /var/lib/jenkins/.ssh/EC2.pem -o StrictHostKeyChecking=no index.html ubuntu@172.31.31.63:/var/www/html                    
echo "======Build Finished====="