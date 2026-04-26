resource "aws_db_instance" "example" {
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    db_name = "appdb"

    username = local.db_credentials["username"]
    password = local.db_credentials["password"]

    allocated_storage = 10
    skip_final_snapshot = true
}