resource "aws_security_group_rule" "http" {
    type = "ingress"
    security_group_id = "aws_security_group.web_sg.id"

    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}