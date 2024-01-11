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
    subnet_id = aws_subnet.demo-public-subnet-1.id
}

resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "ssh access"
  vpc_id = aws_vpc.demo-vpc.id

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

resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_subnet" "demo-public-subnet-1" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = {
    Name = "demo-public-subnet-1"
  }
}

resource "aws_subnet" "demo-public-subnet-2" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = {
    Name = "demo-public-subnet-2"
  }
}

resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "demo-igw"
  }
}

resource "aws_route_table" "demo-public-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }
  tags = {
    Name = "demo-public-rt"
  }
}

resource "aws_route_table_association" "demo-rta-public-subnet-1" {
  subnet_id = aws_subnet.demo-public-subnet-1.id
  route_table_id = aws_route_table.demo-public-rt.id
}

resource "aws_route_table_association" "demo-rta-public-subnet-2" {
  subnet_id = aws_subnet.demo-public-subnet-2.id
  route_table_id = aws_route_table.demo-public-rt.id
}
