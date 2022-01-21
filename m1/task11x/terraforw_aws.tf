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


# Creating instanse 1
resource "aws_instance" "WEB1" {
    count = 0
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.allow_ALL.id]
    user_data = <<EOF


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
