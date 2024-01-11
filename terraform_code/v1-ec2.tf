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