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


resource "aws_eip" "elastick_ip_WEB1" {
  instance = aws_instance.WEB1.id
}




# Creating instanse 1
resource "aws_instance" "WEB1" {
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.allow_ALL.id]
    key_name = "EC2_us-east-1a"
    user_data = file("ec2_userdata/apache.sh")
    tags = {
      Name = "WEB1"
    }
    lifecycle {
      create_before_destroy = true
    }
}


# security_group
resource "aws_security_group" "allow_ALL" {
  name        = "allow_ALL"


  dynamic "ingress" {     #inbound trafick
    for_each = ["22", "80", "8080"]
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
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


# Output zone ====================================

output "WEB1_publick_ip" {
  value = aws_eip.elastick_ip_WEB1.public_ip
}
output "WEB1_private_ip" {
  value = aws_instance.WEB1.private_ip
}
