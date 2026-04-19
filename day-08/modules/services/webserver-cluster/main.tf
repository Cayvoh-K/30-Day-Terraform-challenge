provider "aws" {
  region = "us-east-1"
}

# ✅ AMI DATA SOURCE (MISSING IN YOUR FILE — FIXED HERE)
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# ✅ SUBNET DATA SOURCE
data "aws_subnets" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

# ✅ LAUNCH TEMPLATE
resource "aws_launch_template" "example" {
  name_prefix   = var.cluster_name
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

   user_data = base64encode(
  templatefile("${path.module}/user-data.sh", {
    server_port = var.server_port
  })
)
}
# ✅ AUTO SCALING GROUP
resource "aws_autoscaling_group" "example" {
  desired_capacity = var.min_size
  max_size         = var.max_size
  min_size         = var.min_size

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  vpc_zone_identifier = data.aws_subnets.default.ids
}