# Day 5: Scaling Infrastructure with AWS ALB & Auto Scaling (Terraform)

This project is part of my **30-Day Terraform Challenge**, where I’m building and scaling cloud infrastructure step by step.

On Day 5, I extended my previous setup by introducing an **AWS Application Load Balancer (ALB)** in front of an **Auto Scaling Group (ASG)** to create a highly available and fault-tolerant architecture.


## Architecture Overview

User → Application Load Balancer → Target Group → Auto Scaling Group → EC2 Instances


## What I Built

- ✅ Application Load Balancer (ALB)
- ✅ Target Group with HTTP health checks
- ✅ Auto Scaling Group (ASG)
- ✅ Launch Template for EC2 instances
- ✅ Secure Security Groups (ALB → EC2 only)
- ✅ Output for ALB DNS


## Security Design

- ALB allows inbound HTTP traffic from the internet (port 80)
- EC2 instances **do NOT allow public access**
- Only the ALB can communicate with EC2 instances


## Project Structure

```
.
├── main.tf
├── variables.tf
├── security-groups.tf
├── alb.tf
├── target-group.tf
├── listener.tf
├── asg.tf
├── outputs.tf
```


## How to Deploy

### 1. Initialize Terraform
```
terraform init
```
<img width="1013" height="288" alt="Screen Shot 2026-03-30 at 13 09 25" src="https://github.com/user-attachments/assets/0e6e2f17-ef2b-4fbd-bfae-9318dab12bb9" />

### 2. Format & Validate
```
terraform fmt
terraform validate
```

### 3. Plan
```
terraform plan
```
<img width="1012" height="438" alt="Screen Shot 2026-03-30 at 13 10 22" src="https://github.com/user-attachments/assets/121febd8-8c6b-46da-967a-456054fb3e4f" />

### 4. Apply
```
terraform apply
```
<img width="992" height="467" alt="Screen Shot 2026-03-31 at 06 21 01" src="https://github.com/user-attachments/assets/b76186e9-2101-40da-bb06-c22a6a6379e2" />


## 🌐 Access the Application

After deployment, get the ALB DNS:

```
terraform output alb_dns_name
```
<img width="993" height="53" alt="Screen Shot 2026-04-06 at 23 17 26" src="https://github.com/user-attachments/assets/3fb75d32-aa95-4695-a061-9b735a9bfad7" />

Open in browser:

```
http://<alb_dns_name>
```


## Testing

### Load Balancing
- Refresh the page multiple times
- Traffic is distributed across instances

###  Fault Tolerance
- Terminate one EC2 instance
- ALB continues serving traffic
- ASG automatically launches a replacement instance


## Screenshots

### Application Load Balancer in Action

<img width="1270" height="552" alt="Screen Shot 2026-04-06 at 22 40 42" src="https://github.com/user-attachments/assets/8c1def14-f1bc-492e-8e4b-d30c898b3e11" />


### EC2 Instances (Auto Scaling Group)

<img width="1278" height="530" alt="Screen Shot 2026-04-06 at 22 40 26" src="https://github.com/user-attachments/assets/705ace4f-396e-45c7-aed8-efa17d0b9a66" />

### Target Group Health Checks

<img width="1272" height="320" alt="Screen Shot 2026-04-06 at 22 40 00" src="https://github.com/user-attachments/assets/8e45a123-dd2b-4a75-b2aa-632e631d29f1" />


## Key Learnings

- Infrastructure can be scaled automatically using Auto Scaling Groups
- Load balancers improve availability and reliability
- Terraform enables fully reproducible infrastructure
- Cloud environments have real constraints (instance types, AZs)
