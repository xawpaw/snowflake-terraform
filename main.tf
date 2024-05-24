provider "snowflake" {
  username = var.snowflake_username
  password = var.snowflake_password
  account  = var.snowflake_account
  role     = var.snowflake_role
}

resource "snowflake_warehouse" "my_warehouse" {
  name                = "MY_WAREHOUSE"
  size                = "XSMALL"
  auto_suspend        = 60
  auto_resume         = true
  initially_suspended = true
}

resource "snowflake_database" "my_database" {
  name = "MY_DATABASE"
}

resource "snowflake_schema" "my_schema" {
  name     = "MY_SCHEMA"
  database = snowflake_database.my_database.name
}

resource "snowflake_role" "my_role" {
  name = "MY_ROLE"
}

resource "snowflake_user" "my_user" {
  name       = "MY_USER"
  login_name = "my_user"
  password   = "StrongPassword123!"
  default_warehouse = snowflake_warehouse.my_warehouse.name
  default_role      = snowflake_role.my_role.name
}

resource "snowflake_role_grants" "my_user_role_grant" {
  role_name = snowflake_role.my_role.name
  users     = [snowflake_user.my_user.name]
}

resource "snowflake_database_grant" "my_database_grant" {
  database_name = snowflake_database.my_database.name
  roles         = [snowflake_role.my_role.name]
  privilege     = "USAGE"
}

resource "snowflake_schema_grant" "my_schema_grant" {
  schema_name   = snowflake_schema.my_schema.name
  database_name = snowflake_database.my_database.name
  roles         = [snowflake_role.my_role.name]
  privilege     = "USAGE"
}

resource "snowflake_table" "my_table" {
  name      = "MY_TABLE"
  database  = snowflake_database.my_database.name
  schema    = snowflake_schema.my_schema.name
  comment   = "This is my table"
  column {
    name = "ID"
    type = "NUMBER(38,0)"
  }
  column {
    name = "NAME"
    type = "STRING"
  }
}

resource "snowflake_table_grant" "my_table_grant" {
  table_name   = snowflake_table.my_table.name
  schema_name  = snowflake_schema.my_schema.name
  database_name = snowflake_database.my_database.name
  roles         = [snowflake_role.my_role.name]
  privilege     = "SELECT"
}
