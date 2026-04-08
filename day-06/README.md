# Terraform Remote State with S3 & DynamoDB 

## Project Overview

This project demonstrates how to deploy AWS infrastructure using
Terraform and manage Terraform state effectively using both local and
remote backends.

In this project, I Deployed an EC2 instance using Terraform
- Explored and analyzed the Terraform state file
- Observed how Terraform tracks infrastructure
- Migrated state from local storage to a remote backend (S3)
- Implemented state locking using DynamoDB


## Infrastructure Deployed

-   AWS EC2 Instance (`t3.micro`)
-   AWS S3 Bucket (for remote state storage)
-   AWS DynamoDB Table (for state locking)


## Project Structure

    .
    ├── main.tf
    ├── backend.tf
    ├── terraform.tfstate
    └── README.md

##  Terraform State Exploration

After running:

    terraform apply

I inspected the state file:

    cat terraform.tfstate

###  Key Observations

-   Terraform stores resources under the "resources" block
-   Each resource includes:
    -   Type (e.g., aws_instance)
    -   Name
    -   Attributes (AMI, IP, tags, etc.)
    -   Resource ID
-   Dependencies are tracked internally
-   Sensitive values may be stored in plaintext


##  Problems with Local State

-   No state locking → risk of concurrent changes
-   Easy to lose (stored locally)
-   Contains sensitive data in plaintext


## Remote State Setup (S3 + DynamoDB)

### Backend Configuration

    terraform {
      backend "s3" {
        bucket         = "my-terraform-state-cayvoh-2026-001"
        key            = "global/s3/terraform.tfstate"
        region         = "us-east-1"
        dynamodb_table = "terraform-state-locks"
        encrypt        = true
      }
    }


<img width="1018" height="609" alt="Screen Shot 2026-04-07 at 22 49 50" src="https://github.com/user-attachments/assets/7abadb71-326d-488e-9afd-9b4bb0326874" />


### State Migration

    terraform init

Terraform prompts to migrate local state → confirmed.

<img width="1011" height="476" alt="Screen Shot 2026-04-07 at 22 48 25" src="https://github.com/user-attachments/assets/21a09a67-6dff-4164-89f7-f27d6c16cc4c" />

<img width="1273" height="548" alt="Screen Shot 2026-04-08 at 06 51 55" src="https://github.com/user-attachments/assets/dfe88452-bd37-441e-a056-41adba6e68b0" />


## State Locking Test

Tested using two terminals:

Terminal 1:

    terraform apply

Terminal 2:

    terraform plan

### Result

Terraform prevented concurrent execution using DynamoDB locking.


## Useful Commands

    terraform state list
    terraform state show aws_instance.example
    terraform destroy

## Key Learnings

-   Terraform state is the source of truth
-   Remote state enables team collaboration
-   S3 provides durable and versioned storage
-   DynamoDB ensures safe state locking
-   Local state is not suitable for teams


## Challenges Faced & Fixes

-   Invalid instance type → switched to `t3.micro`
-   AMI mismatch → used dynamic AMI data source
-   Region mismatch → standardized to `us-east-1`
-   Invalid bucket name → used lowercase naming
-   Bucket already exists → added unique suffix


## Conclusion

This project provided hands-on experience with Terraform state
management and demonstrated why remote state is essential in real-world
DevOps workflows.

