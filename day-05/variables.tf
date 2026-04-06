variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "server_port" {
  default = 80
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 3
}