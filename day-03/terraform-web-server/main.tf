provider "aws" {
    region = "us-east-1"
}

# Security Group (Allow HTTP)
resource "aws_security_group" "web_sg" {
    name = "web_sg"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#EC2 Instance
resource "aws_instance" "web_server" {
    ami         = "ami-0c02fb55956c7d316"
    instance_type = "t3.micro"

    security_groups = [aws_security_group.web_sg.name]
    user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Terraform 🚀</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Terraform-Web-Server"
  }
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}
