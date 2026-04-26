data "aws_secretsmanager_secret" "db_credentials" {
    name = "prod/db/credentials"
}

data "aws_secretsmanager_secret_version" "db_credetentials" {
    secret_id = data.aws_secretsmanager_secret.db_credentials.id
}