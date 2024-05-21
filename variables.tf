variable "snowflake_username" {
  description = "The username for Snowflake"
  type        = string
}

variable "snowflake_password" {
  description = "The password for Snowflake"
  type        = string
  sensitive   = true
}

variable "snowflake_account" {
  description = "The account identifier for Snowflake"
  type        = string
}

variable "snowflake_role" {
  description = "The role to use for Snowflake"
  type        = string
  default     = "SYSADMIN"
}
