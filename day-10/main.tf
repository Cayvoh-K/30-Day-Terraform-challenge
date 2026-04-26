provider "aws" {
    region = "us-east-1"
}

module "webserver" {
    source = "./modules/webserver"

    ami = "ami-123456"
    instance_type = "t2.micro"
}

output "instance_id" {
    value = module.webserver.instance_id
}