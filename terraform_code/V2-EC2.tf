provider "aws" {
  region = "us-east-1"
  access_key = "AKIARY7CNIPSRAGXSRSP"
  secret_key = "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"
}

resource "aws_instance" "demo_server" {
    ami = "ami-0005e0cfe09cc9050"
    instance_type = "t2.micro"
    key_name = "devops_project"
    security_groups = [ demo_sg ]
}

resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "ssh access"

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [0.0.0.0/0]
  }

  tags = {
    Name = "ssh=access"
  }
}