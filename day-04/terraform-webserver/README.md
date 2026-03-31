# Terraform AWS Web Server & Cluster Deployment

##  Project Overview

This project demonstrates how to deploy both a configurable single web server and a scalable clustered web server architecture on AWS using Terraform.

The goal was to eliminate hardcoding, apply the DRY principle, and build infrastructure that is reusable, configurable, and production-ready.


##  Objectives

- Remove all hardcoded values using input variables
- Build reusable Terraform configurations
- Deploy a single EC2-based web server
- Extend the setup to a scalable cluster using:
  - Auto Scaling Group (ASG)
  - Application Load Balancer (ALB)
- Handle real-world AWS constraints (e.g., AZ limitations)


##  Architecture

### Phase 1: Single Server

- EC2 Instance
- Security Group (HTTP access on configurable port)
- User data script to run a simple web server


### Phase 2: Clustered Setup

- Launch Template
- Auto Scaling Group (min: 2, max: 5)
- Application Load Balancer (ALB)
- Target Group & Listener
- Multi-AZ deployment (excluding unsupported AZ)


##  Project Structure

.
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
└── README.md

---

##  Variables

Defined in variables.tf:

- aws_region → AWS region
- instance_type → EC2 instance type
- server_port → HTTP port (default: 8080)
- server_name → Name tag
- min_size → ASG minimum instances
- max_size → ASG maximum instances


##  Key Concepts Applied

- No Hardcoding → All values are configurable via variables
- DRY Principle → Reusable and clean Terraform code
- Data Sources → Dynamic retrieval of:
  - AMI
  - VPC
  - Subnets
- Scalability → Transition from single server to clustered architecture
- High Availability → Multi-AZ deployment


## Challenges Faced

### 1. Invalid AMI Error
- Fixed by using a dynamic AMI data source instead of hardcoding

### 2. Free Tier Limitations
- New AWS accounts may not support t2.micro
- Switched to t3.micro

### 3. Availability Zone Constraint
- t3.micro not supported in us-east-1e
- Resolved by filtering subnets to exclude unsupported AZ



##  How to Deploy

### 1. Initialize Terraform

terraform init


<img width="1013" height="288" alt="Screen Shot 2026-03-30 at 13 09 25" src="https://github.com/user-attachments/assets/158e0b62-3a9c-4b36-8eba-e4ed26527301" />


### 2. Preview Changes

terraform plan

<img width="1012" height="438" alt="Screen Shot 2026-03-30 at 13 10 22" src="https://github.com/user-attachments/assets/88789100-7594-4b9a-9a2e-44164d23300d" />


### 3. Apply Configuration

terraform apply


<img width="992" height="467" alt="Screen Shot 2026-03-31 at 06 21 01" src="https://github.com/user-attachments/assets/9c08cb3f-2565-402e-ae00-77ff0f10b045" />


### 4. Access the Application

After deployment:

terraform output alb_dns_name

Open in browser:

http://<alb_dns_name>


<img width="1276" height="735" alt="Screen Shot 2026-03-31 at 21 01 28" src="https://github.com/user-attachments/assets/54720dff-7ba9-4f46-8818-60678321b0f6" />

##  Testing

- Confirm web page loads
- Refresh multiple times to simulate load balancing
- Verify instances are healthy in Target Group



##  Clean Up

To avoid AWS charges:

terraform destroy



##  Lessons Learned

- Infrastructure should be configurable, not hardcoded
- AWS environments have real-world constraints (AZ limitations)
- Debugging Terraform requires understanding both:
  - Terraform logic
  - Cloud provider behavior
- Scalable systems require proper network and resource design

