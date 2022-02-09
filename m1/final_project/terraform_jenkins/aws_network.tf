
#create main vpc
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Main"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main"
  }
}

#create subnet in main vpc
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Main"
  }
}

#==========ROUTES===================================

resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  tags = {
    Name = "Main"
  }
}

resource "aws_route" "main" {
    route_table_id = aws_default_route_table.main.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
    depends_on = [aws_default_route_table.main]
}   


# ===========security_group============================
resource "aws_security_group" "allow_ALL" {
  name        = "allow_ALL"
  vpc_id = aws_vpc.main.id

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

