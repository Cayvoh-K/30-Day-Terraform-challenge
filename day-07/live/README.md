# Terraform Day 7: State Management & Isolation

## Overview

This project demonstrates how to manage Terraform state effectively across multiple environments using:

- Remote Backends (S3)
- State Locking (DynamoDB)
- Workspaces (same code, multiple states)
- File Layout Isolation (separate directories per environment)
- Remote State Data Source

This is a critical concept in real-world DevOps workflows and highly relevant for the Terraform Associate exam.


## Project Structure

```
terraform-day7/
├── live/                     # Workspace-based setup
│   ├── backend.tf
│   ├── main.tf
│   └── variables.tf
│
└── environments/             # File layout isolation
    ├── dev/
    │   ├── main.tf
    │   ├── backend.tf
    │   └── outputs.tf
    ├── staging/
    │   ├── main.tf
    │   └── backend.tf
    └── production/
        ├── main.tf
        └── backend.tf
```


## Remote Backend Configuration

Terraform state is stored remotely in an S3 bucket with state locking enabled using DynamoDB.

```hcl
terraform {
  backend "s3" {
    bucket         = "your-s3-bucket-name"
    key            = "global/single-state/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
```

<img width="1018" height="609" alt="Screen Shot 2026-04-07 at 22 49 50" src="https://github.com/user-attachments/assets/7b38c900-0296-4134-a4d0-0ce840e16c43" />


## Lab 1: State Management

- Initialized Terraform with remote backend
- Applied infrastructure changes
- Verified state file is stored in S3 instead of locally


## Lab 2: State Locking

- Simulated concurrent Terraform runs
- Verified DynamoDB prevents multiple state modifications

<img width="1011" height="476" alt="Screen Shot 2026-04-07 at 22 48 25" src="https://github.com/user-attachments/assets/9795221b-6d83-4e42-9bd5-e30c76ff6282" />



## State Isolation via Workspaces

### Create Workspaces

```
terraform workspace new dev
terraform workspace new staging
terraform workspace new production
```

### Switch Workspace

```
terraform workspace select dev
```

<img width="990" height="280" alt="Screen Shot 2026-04-10 at 06 16 42" src="https://github.com/user-attachments/assets/598682f5-7c02-46ab-89c8-29207f4acfb6" />

<img width="973" height="298" alt="Screen Shot 2026-04-10 at 06 35 03" src="https://github.com/user-attachments/assets/1b4caa7c-b5ed-4ea2-b706-6d29d817f80c" />



### Conditional Configuration

```hcl
variable "instance_type" {
  type = map(string)

  default = {
    dev        = "t2.micro"
    staging    = "t2.micro"
    production = "t2.micro"
  }
}
```

```hcl
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type[terraform.workspace]

  tags = {
    Name        = "web-${terraform.workspace}"
    Environment = terraform.workspace
  }
}
```


## State Isolation via File Layout

Each environment has its own directory and backend configuration.

### Example: `environments/dev/backend.tf`

```hcl
terraform {
  backend "s3" {
    bucket         = "your-s3-bucket-name"
    key            = "environments/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
```

### Deploy per environment

```
cd environments/dev
terraform init
terraform apply
```
<img width="1011" height="476" alt="Screen Shot 2026-04-07 at 22 48 25" src="https://github.com/user-attachments/assets/bdeaf2ea-924b-410e-a2e5-efe604162793" />

<img width="997" height="200" alt="Screen Shot 2026-04-10 at 06 16 04" src="https://github.com/user-attachments/assets/39cafdaa-34ff-4c4a-946d-20208eacb03f" />

## Remote State Data Source

Used to share outputs between configurations.

```hcl
data "terraform_remote_state" "dev" {
  backend = "s3"

  config = {
    bucket = "your-s3-bucket-name"
    key    = "environments/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
```


##  Key Learnings

- Terraform state must be isolated to avoid conflicts
- Workspaces provide convenience but can be risky
- File layout provides strong isolation and is production-ready
- Remote state enables modular infrastructure design
- State locking prevents concurrent modifications


## Conclusion

This project demonstrates how to manage Terraform infrastructure safely and efficiently across multiple environments.
