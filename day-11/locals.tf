locals {
    is_production = var.environment == "production"

    instance_type = local.is_production ? "t2.medium" : "t2.micro"
    min_size = local.is_production ? 3 : 1
    max_size = local.is_production ? 10 : 3
    enable_monitoring = local.is_production || var.enable_detailed_monitoring
}