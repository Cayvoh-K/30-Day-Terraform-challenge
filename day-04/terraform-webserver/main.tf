provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "availability-zone"
    values = [
      "us-east-1a",
      "us-east-1b",
      "us-east-1c",
      "us-east-1d",
      "us-east-1f"
    ]
  }
}

resource "aws_security_group" "web_sg" {
  name = "${var.server_name}-sg"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#resource "aws_instance" "web" {
# ami           = data.aws_ami.amazon_linux.id
#instance_type = var.instance_type

#vpc_security_group_ids = [aws_security_group.web_sg.id]

#user_data = <<-EOF
#              #!/bin/bash
#             yum update -y

#            echo "Hello from Terraform" > index.html
#           nohup python3 -m http.server ${var.server_port} &
#          EOF

#tags = {
# Name = var.server_name
#}
#}

resource "aws_launch_template" "web" {
  name_prefix   = "web-template-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              wcho "Hello from cluster" > index.html
              nohup budybox httpd -f -p ${var.server_port} &
              EOF
  )
}

resource "aws_lb_target_group" "web" {
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

resource "aws_lb" "web" {
  name               = "web-alb"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = var.server_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_autoscaling_group" "web" {
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = 2

  vpc_zone_identifier = data.aws_subnets.default.ids
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.web.arn]
}