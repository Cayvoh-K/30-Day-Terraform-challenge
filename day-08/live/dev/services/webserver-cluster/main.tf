provider "aws" {
    region = "us-east-1"
}

module "webserver_cluster" {
    source = "github.com/Cayvoh-K/30-Day-Terraform-challenge//modules/services/webserver-cluster?ref=v0.0.1"

    cluster_name = "webservers-dev"
    instance_type = "t3.micro"
    min_size = 2
    max_size = 4
}

output "asg_name" {
    value = module.webserver_cluster.asg_name
}