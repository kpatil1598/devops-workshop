provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "demo_server" {
    ami = "ami-0005e0cfe09cc9050"
    instance_type = "t2.micro"
    key_name = "devops_project"
    vpc_security_group_ids = [ aws_security_group.demo_sg.id ]
}

resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "ssh access"

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-access"
  }
}

output "public_ip" {
  value       = aws_instance.demo_server.public_ip
  description = "public_ip address"
}
