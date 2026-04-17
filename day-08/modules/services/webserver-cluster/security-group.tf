resource "aws_security_group" "web_sg" {
    name = "${var.cluster_name}-sg"
}