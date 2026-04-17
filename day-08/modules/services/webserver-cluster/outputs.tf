output "asg_name" {
    value = aws_autoscaling_group.example
    description = "The name of the Auto Scaling Group"
}

output "alb_dns_name" {
    value = "example-alb-dns"
    description = "The domain name of the load balancer"
}

output "instance_ids" {
    value = aws_instance.web[*].id
}