provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "dev-server" {
  ami = "ami-024e6efaf93d85776"
  instance_type = "t2.micro"
  key_name = "test"
  security_groups = [ "dev-sg" ]
  for_each = toset(["master", "slave", "Ansible" ])
   tags = {
     Name = "${each.key}"
   }
}

resource "aws_security_group" "dev-sg" {
  name        = "dev-sg"
  description = "Allow SSH"
  


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

