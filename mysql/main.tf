terraform {
    backend "s3" {
        bucket = "tf-up-and-running-state-bucket"
        key = "data-stores/s3/terraform.tfstate"
        region = "us-east-2"

        dynamodb_table = "tf-up-and-running-lock-table"
        encrypt= "true"
    }
}

resource "aws_db_instance" "example" {
    identifier_prefix = "terraform-up-and-running"
    engine = "mysql"
    allocated_storage = 10
    instance_class = "db.t2.micro"
    name = "example_database"
    username = "admin"
    password = "data.aws_secretsmanager_secret_version.db_password.secret_string"
}

data "aws_secretsmanager_secret_version" "db_password" {
    secret_id = "tf-up-and-running-mysql-password"
}
