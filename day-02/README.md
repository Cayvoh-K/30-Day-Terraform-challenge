# Environment Setup (Day 2)

This guide walks through setting up a complete and secure environment
for working with Terraform and AWS.


##  1. AWS Account Setup

-   Create an AWS account if you don't already have one\
-   Enable **MFA (Multi-Factor Authentication)** on your root account
    immediately\
-   Set up a **billing alert** to avoid unexpected charges


##  2. Create IAM User (For Terraform)

Do NOT use root account credentials

-   Go to IAM in AWS Console\
-   Create a new user (e.g., `terraform-user`)\
-   Enable **Programmatic Access**\
-   Attach permissions (e.g., `AdministratorAccess` for learning)\
-   Save your:
    -   Access Key ID\
    -   Secret Access Key


##  3. Install Terraform

Download and install the latest version of Terraform

Verify installation:

    terraform version

<img width="1016" height="86" alt="Screen Shot 2026-03-28 at 21 32 05" src="https://github.com/user-attachments/assets/fa66b859-2562-4edd-b52a-66fe0aca306a" />


##  4. Install AWS CLI

Install AWS CLI on your machine

Configure it:

    aws configure

<img width="1015" height="46" alt="Screen Shot 2026-03-28 at 21 32 36" src="https://github.com/user-attachments/assets/90ee6265-80f7-4c1a-bf1a-a87710eeb5cf" />

Enter: - AWS Access Key ID\
- AWS Secret Access Key\
- Default region (e.g., `us-east-1`)\
- Output format (`json` recommended)

<img width="1013" height="132" alt="Screen Shot 2026-03-28 at 21 32 58" src="https://github.com/user-attachments/assets/99ad686f-f413-4f8e-b386-8e2fd50d339f" />


##  5. Install Visual Studio Code Extensions

Install these extensions in VS Code:

-   HashiCorp Terraform\
-   AWS Toolkit


##  6. Full Environment Validation

Run all commands below:

    terraform version
    aws --version
    aws sts get-caller-identity
    aws configure list

###  Expected Result:

-   No errors
-   AWS identity command returns your IAM user
-   Configuration shows correct region and credentials


##  Important Notes

-   Never expose your AWS credentials
-   Always use IAM users (not root account)
-   Ensure everything works before moving forward

