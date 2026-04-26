output "db_endpoint" {
    value = aws_db_instance.example.endpoint
}

output "db_connection_string" {
    value = "mysql://${aws_db_instance.example.username}@${aws_db_instance.example.endpoint}"
    sensitive = true
}