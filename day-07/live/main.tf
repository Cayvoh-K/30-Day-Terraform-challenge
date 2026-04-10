provider "aws" {
    region = "us-east-1"
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags = {
    Name = "day7-instance"
  }
}

resource "aws_instance" "web" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type[terraform.workspace]

    tags = {
        Name = "web-${terraform.workspace}"
        environment = terraform.workspace
    }
}