variable "environment" {
    description = "Deployment environment: dev, staging, or production"
    type = string
    default = "dev"

    validation {
        condition = contains(["dev", "staging", "production"], var.environment)
        error_message = "Environment must be dev, staging, or production."
    }
}

variable "enable_detailed_monitoring" {
 description = "Enable Cloudwatch detailed monitoring"
 type = bool
 default = false
}

variable "create_dns_record" {
    description = "whether to create a DNS record"
    type = bool
    default = false
}