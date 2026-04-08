provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "example" {
    ami = "ami-0c02fb55956c7d316"
    instance_type = "t3.micro"

    tags = {
        Name = "terraform-state-demo"
    }
}

terraform {
    backend "s3" {
        bucket = "my-terraform-state-cayvoh"
        key = "global/s3/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "terraform-state-locks"
        encrypt = true
    }
}