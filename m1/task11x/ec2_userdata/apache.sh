#!/bin/bash

sudo apt update

sudo apt install apache2 -y 
sudo ufw allow in "Apache"
sudo service apache2 start


sudo useradd -m web1
sudo mkdir /home/web1/.ssh

cat > authorized_keys <<TXT
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsrjOk85Ms1FVa2Vm0WXc4gFRy0N71FRwl9vJOc6yAQGXkz8j3BcoD6ZuALDUN/XtbFig7DH/7MDlW4xmyR/OJByxC67RgnF2bmS7EB89jn5FET3PfVx8H9pvrv5773oYDvjhcRaeGtr6IzyxPO2mN0QeMd94+nPtJUY9dN7kYJfLXpIxnGIc0Y8dL98KDawxGMULVAYrUk+dLwBwPpI+MIx+Q9SXF2lvgk3vMdkTb6kyVZRkSA67UgsPWCo01UEK9WQYz5iqcGQeVwmkBbrzFPPKgr/3mWnVUQ2Yvpwo1dFPx3iaEj5cCTC2d4Q4DlqHi2aSer3Afy1YjX/vkQODyelLyjuIsnUv84gTkC13SMXGnUo+bthuiMONoAQm6oZDa4Qw+5UFRWqQTPdTODQVfYFcHksTOep+MFaLv2/eyfh9w5SECO4gkigb9PK8z4tSbdMiCZQemYyfHgkYnijTf6Rq1g43aoOyu+VIOeqHomWpVSRygiqjL9kdsNwfRxz8= ubuntu@ip-172-31-31-63
TXT
sudo mv authorized_keys /home/web1/.ssh/


sudo chown web1:web1 /home/web1/.ssh/authorized_keys
sudo chmod 600 /home/web1/.ssh/authorized_keys
sudo chmod 700 /home/web1/.ssh

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
cat /var/www/html/index.html



sudo apt upgrade -y






