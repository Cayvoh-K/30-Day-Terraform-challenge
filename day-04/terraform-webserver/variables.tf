variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "server_port" {
  description = "The port the server will use for HTTP request"
  type        = number
  default     = 8080
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "server_name" {
  description = "Server name"
  type        = string
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

variable "min_size" {
  description = "Maximum number of instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
}