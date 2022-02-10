# Connect to AWS
#Use next comand for add KEYs to system.
#Linux
#export AWS_ACCESS_KEY_ID=
#export AWS_SECRET_ACCESS_KEY=

#Windows
#set AWS_ACCESS_KEY_ID=
#set AWS_SECRET_ACCESS_KEY=

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
    region = "us-east-1"
}

#sshkey
resource "aws_key_pair" "EC2_us-east-1a" {
  key_name   = "EC2_us-east-1a"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCkt8OVZQC2DYyqf7VCj6lMJKvARg3/n/lTipxi76RhbMU8MIduI+OjyLH0oA5N10zG8KFu0ZsI6VuNvcfDlBBVcocjxezz7fjApN1+6rUvw3MGwyvgJXLIuOhaDJDg66KJjHb5tIlxBMUz3YRxpGbkcKOYjg5pRitZ9tNHOv4e07XpDOQMq4ZaACbiPxDSlgkSS4/ZSGElNetgVxI+JLutLe3Ai5ND4B1nGs178CKUudkT+TsXKcblpBGytVGDN5zucGT3nbnjjk0aAwIKPun19CQQ9EsMSHXWDklr2l0RTPPPTnIoJSNDVjN518rZXmmWugAITw8cgYaYf7HF22V7 EC2"
}



#elastik ip
resource "aws_eip" "elastick_ip_WEB_2" {
  instance = aws_instance.WEB_2.id
}

# Creating instanse
resource "aws_instance" "WEB_2" {
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    key_name = "EC2_us-east-1a"
    user_data = file("apache.sh")
    subnet_id   = aws_subnet.main.id
    security_groups = [aws_security_group.allow_ALL.id]

    tags = {
      Name = "WEB_2"
    }
    lifecycle {
      create_before_destroy = true
    }
}



# Output zone ====================================

output "WEB_2_publick_ip" {
  value = aws_instance.WEB_2.public_ip
}
output "WEB_2_private_ip" {
  value = aws_instance.WEB_2.private_ip
}
