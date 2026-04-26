resource "aws_launch_template" "example" {
  name_prefix   = "demo-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = base64encode(file("${path.module}/user-data.sh"))
}

resource "aws_autoscaling_group" "blue" {
  name_prefix         = "demo-blue-"
  vpc_zone_identifier = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.blue.arn]

  min_size = 1
  max_size = 2

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "green" {
  name_prefix         = "demo-green-"
  vpc_zone_identifier = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.green.arn]

  min_size = 1
  max_size = 2

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }
}