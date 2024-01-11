provider "aws" {
  region = "us-east-1"
  access_key = "AKIARY7CNIPSRAGXSRSP"
  secret_key = "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"
}

resource "aws_instance" "web" {
    ami = "ami-0005e0cfe09cc9050"
    instance_type = "t2.micro"
    key_name = "devops_project"
}