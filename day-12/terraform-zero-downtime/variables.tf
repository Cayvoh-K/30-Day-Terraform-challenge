variable "cluster_name" {
  default = "demo-cluster"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "server_port" {
  default = 80
}

variable "min_size" {
  default = 2
}

variable "max_size" {
  default = 3
}

variable "active_environment" {
  description = "blue or green"
  default     = "blue"
}
