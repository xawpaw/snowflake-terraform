provider "snowflake" {
  username = var.snowflake_username
  password = var.snowflake_password
  account  = var.snowflake_account
  role     = var.snowflake_role
}

resource "snowflake_warehouse" "my_warehouse" {
  name            = "MY_WAREHOUSE"
  size            = "XSMALL"
  auto_suspend    = 60
  auto_resume     = true
  initially_suspended = true
}

resource "snowflake_database" "my_database" {
  name = "MY_DATABASE"
}

resource "snowflake_schema" "my_schema" {
  name      = "MY_SCHEMA"
  database  = snowflake_database.my_database.name
}
