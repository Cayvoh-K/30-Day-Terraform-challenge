provider "aws" {
    region = "us-east-1"
}

#example EC2 instance
resource "aws_instance" "web" {
    ami = "ami-0c55b159cbfafe1f0"
    instance_type = local.instance_type

    tags = {
        Name = "web-${var.environment}"
    }
}

# Conditional Cloudwatch Alarm
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
    count = local.enable_monitoring ? 1 : 0

    alarm_name = "high-cpu-${var.environment}"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 2
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 120
    statistic = "Average"
    threshold = 80
}