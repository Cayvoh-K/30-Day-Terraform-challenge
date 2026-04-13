provider "aws" {
    region = "us-east-1"
}

module "webserver_cluster" {
    source = "../../../../modules/services/webserver-cluster"

    cluster_name = "webservers-production"
    instance_type = "t3.medium"
    min_size = 4
    max_size = 10
}

