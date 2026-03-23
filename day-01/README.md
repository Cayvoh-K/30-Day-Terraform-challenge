# 30-Day Terraform Challenge - Day 01

## Objective

Set up the local environment for Terraform and AWS, verify connectivity, and run the first Terraform initialization and apply.

---

## Prerequisites

### 1. Terraform

* Install the latest version: [Terraform Downloads](https://developer.hashicorp.com/terraform/downloads)
* Verify installation:

```bash
terraform version
```

**Expected output:**

```text
Terraform v1.13.5
on darwin_amd64
```
<img width="914" height="291" alt="Screen Shot 2026-03-19 at 07 08 48" src="https://github.com/user-attachments/assets/f0059c82-ba37-4a45-8a97-983ae2de5533" />

<img width="924" height="56" alt="Screen Shot 2026-03-19 at 06 55 47" src="https://github.com/user-attachments/assets/02ca3ccb-105c-4eb7-a26e-a556ae00ffdb" />

---

### 2. AWS CLI

* Install AWS CLI: [AWS CLI Installation](https://aws.amazon.com/cli/)
* Configure credentials:

```bash
aws configure
```

You will provide:

* AWS Access Key ID

* AWS Secret Access Key

* Default region (e.g., `us-east-1`)

* Default output format (e.g., `json`)

* Verify configuration:

```bash
aws sts get-caller-identity
```

**Expected output:**

```json
{
    "UserId": "AIDAEXAMPLEUSERID",
    "Account": "322345935879",
    "Arn": "arn:aws:iam::322345935879:user/terraform-user"
}
```
<img width="844" height="75" alt="Screen Shot 2026-03-19 at 06 46 45" src="https://github.com/user-attachments/assets/fc3e1bc7-59c2-4645-a633-d6d796ea0ff8" />
<img width="1273" height="630" alt="Screen Shot 2026-03-18 at 23 01 54" src="https://github.com/user-attachments/assets/1046949d-64ab-43a3-9076-13f8445bdc08" />

---

### 3. Visual Studio Code (VSCode)

* Install VSCode: [VSCode Download](https://code.visualstudio.com/)
* Add extensions:

  * HashiCorp Terraform
  * AWS Toolkit

---

## Terraform Workflow

### 1. Initialize Terraform

```bash
terraform init
```

**Expected output:**

```text
Initializing provider plugins...
- Installing hashicorp/aws v6.37.0...
Terraform has been successfully initialized!
```

### 2. Apply Terraform Configuration

```bash
terraform apply
```

* Review the plan
* Type `yes` to confirm

**Expected output:**

```text
Plan: 1 to add, 0 to change, 0 to destroy.
aws_s3_bucket.example: Creation complete after 2s
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```


---

## Lessons Learned

* `.terraform` folder and provider binaries should **not** be committed to GitHub; use `.gitignore`.
* Verify AWS credentials with `aws sts get-caller-identity` before running Terraform.
* VSCode extensions improve workflow and syntax highlighting for HCL and AWS resources.

