terraform {
    backend "s3" {
        bucket = "my-terraform-state-cayvoh"
        key = "global/single-state/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "terraform-state-locks"
        encrypt = true
    }
}