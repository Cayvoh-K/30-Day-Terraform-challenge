terraform {
    backend "s3" {
        bucket = "my-terraform-state-bucket-unique-98765"
        key = "production/terraform.tfstate"
        region = "us-west-2"
        dynamodb_table = "terraform-state-locks"
        encrypt = true
    }
}