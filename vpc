provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "dev-server" {
  ami = "ami-024e6efaf93d85776"
  instance_type = "t2.micro"
  key_name = "test"
  vpc_security_group_ids = [ aws_security_group.dev-sg.id ]
  subnet_id = aws_subnet.dev-sunbet01.id
}

resource "aws_security_group" "dev-sg" {
  name        = "dev-sg"
  description = "Allow SSH"
  vpc_id = aws_vpc.dev-vpc.id


  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "SSH-Port"
  }
}

resource "aws_vpc" "dev-vpc" {
  
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "dev-vpc"
  }
}

resource "aws_subnet" "dev-sunbet01" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2a"
  tags = {
    Name = "dev-subnet01"
  }
}

resource "aws_subnet" "dev-sunbet02" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2b"
  tags = {
    Name = "dev-subnet02"
  }
}

resource "aws_internet_gateway" "dev-ig" {
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = "dev-ig"
  }
}


resource "aws_route_table" "dev-rt" {
  vpc_id = aws_vpc.dev-vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-ig.id
    
  }
}

resource "aws_route_table_association" "dev-rta01" {
subnet_id = aws_subnet.dev-sunbet01.id
route_table_id = aws_route_table.dev-rt.id

}

resource "aws_route_table_association" "dev-rta02" {
subnet_id = aws_subnet.dev-sunbet02.id
route_table_id = aws_route_table.dev-rt.id

}