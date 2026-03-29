#  Terraform AWS Web Server Deployment

This project demonstrates how to deploy a basic web server on AWS using Terraform.

##  Project Overview

- Provision an EC2 instance
- Configure a security group to allow HTTP (port 80)
- Automatically install and run a web server
- Output the public IP for access

---

##  Terraform Configuration (main.tf)

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web_sg" {
  name = "web_sg"

  ingress {
    from_port   = 80
    to_port     = 80
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

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
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
```

---

##  How to Run

```bash
aws configure
terraform init
terraform plan
terraform apply
```
<img width="1013" height="132" alt="Screen Shot 2026-03-28 at 21 32 58" src="https://github.com/user-attachments/assets/902342d4-d92d-4b1d-8745-f9fdad9e76f0" />

<img width="1004" height="284" alt="Screen Shot 2026-03-29 at 12 19 00" src="https://github.com/user-attachments/assets/d1fa9fc2-d7d0-40c3-ba1e-0e0a622d0337" />

<img width="1013" height="132" alt="Screen Shot 2026-03-28 at 21 32 58" src="https://github.com/user-attachments/assets/bc225e0b-688a-44c0-8fa0-52d2dbb665d7" />

<img width="993" height="422" alt="Screen Shot 2026-03-29 at 15 12 44" src="https://github.com/user-attachments/assets/1ac24b1d-4399-4e91-ae3b-0a8a319d6226" />

<img width="1015" height="466" alt="Screen Shot 2026-03-29 at 15 21 48" src="https://github.com/user-attachments/assets/e6e0d9b4-3593-4b67-8fb1-0b13c4702fd5" />


Open browser:
http://<public-ip>

---

##  Challenges

- New AWS accounts may not accept `t2.micro` as free-tier
- Fixed by switching to `t3.micro`

---

## 🧹 Cleanup

```bash
terraform destroy
```
