locals {
    db_credentials = jsondecode(
      data.aws_secretsmanager_secret_version.db_credetentials.secret_string
    )
}