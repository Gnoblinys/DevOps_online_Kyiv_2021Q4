# Connect to AWS
#Use next comand for add KEYs to system.
#Linux
#export AWS_ACCESS_KEY_ID=
#export AWS_SECRET_ACCESS_KEY=

#Windows
#set AWS_ACCESS_KEY_ID=
#set AWS_SECRET_ACCESS_KEY=

provider "aws" {
    region = "us-east-1"
}

#sshkey
resource "aws_key_pair" "EC2_us-east-1a" {
  key_name   = "EC2_us-east-1a"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCkt8OVZQC2DYyqf7VCj6lMJKvARg3/n/lTipxi76RhbMU8MIduI+OjyLH0oA5N10zG8KFu0ZsI6VuNvcfDlBBVcocjxezz7fjApN1+6rUvw3MGwyvgJXLIuOhaDJDg66KJjHb5tIlxBMUz3YRxpGbkcKOYjg5pRitZ9tNHOv4e07XpDOQMq4ZaACbiPxDSlgkSS4/ZSGElNetgVxI+JLutLe3Ai5ND4B1nGs178CKUudkT+TsXKcblpBGytVGDN5zucGT3nbnjjk0aAwIKPun19CQQ9EsMSHXWDklr2l0RTPPPTnIoJSNDVjN518rZXmmWugAITw8cgYaYf7HF22V7 EC2"
}


# Creating instanse 1
resource "aws_instance" "WEB1" {
    count = 1
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.allow_ALL.id]
    key_name = "EC2_us-east-1a"
    user_data = <<EOF
#!/bin/bash

sudo apt update

sudo apt install apache2 -y 
sudo ufw allow in "Apache"
sudo service httpd start


sudo useradd -m web1
sudo mkdir /home/web1/.ssh

cat > authorized_keys <<TXT
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsrjOk85Ms1FVa2Vm0WXc4gFRy0N71FRwl9vJOc6yAQGXkz8j3BcoD6ZuALDUN/XtbFig7DH/7MDlW4xmyR/OJByxC67RgnF2bmS7EB89jn5FET3PfVx8H9pvrv5773oYDvjhcRaeGtr6IzyxPO2mN0QeMd94+nPtJUY9dN7kYJfLXpIxnGIc0Y8dL98KDawxGMULVAYrUk+dLwBwPpI+MIx+Q9SXF2lvgk3vMdkTb6kyVZRkSA67UgsPWCo01UEK9WQYz5iqcGQeVwmkBbrzFPPKgr/3mWnVUQ2Yvpwo1dFPx3iaEj5cCTC2d4Q4DlqHi2aSer3Afy1YjX/vkQODyelLyjuIsnUv84gTkC13SMXGnUo+bthuiMONoAQm6oZDa4Qw+5UFRWqQTPdTODQVfYFcHksTOep+MFaLv2/eyfh9w5SECO4gkigb9PK8z4tSbdMiCZQemYyfHgkYnijTf6Rq1g43aoOyu+VIOeqHomWpVSRygiqjL9kdsNwfRxz8= ubuntu@ip-172-31-31-63
TXT
sudo mv authorized_keys /home/web1/.ssh/


sudo chown web1:web1 /home/web1/.ssh/authorized_keys
sudo chmod 600 /home/web1/.ssh/authorized_keys
sudo chmod 700 /home/web1/.ssh


cat > upgrade.sh <<TXT
sudo timedatectl set-timezone Europe/Kiev
sudo apt upgrade -y
rm upgrade.sh

TXT

chmod a+x upgrade.sh
./upgrade.sh

EOF




    tags = {
      Name = "WEB1"
    }
}

# security_group
resource "aws_security_group" "allow_ALL" {
  name        = "allow_ALL"
  description = "Allow some ports"

  ingress {         #inbound trafick
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {              #outbound trafick
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ALL"
  }
}
