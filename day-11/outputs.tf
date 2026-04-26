output "instance_type" {
  value = local.instance_type
}

output "alarm_arn" {
  value = local.enable_monitoring ? aws_cloudwatch_metric_alarm.high_cpu[0].arn : null
}