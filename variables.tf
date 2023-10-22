variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "resource_group_location" {
  type        = string
  description = "Resource group location"
}

variable "service_plan_name" {
  type        = string
  description = "Service plan name"
}

variable "service_plan_type" {
  type        = string
  description = "Service plan type"
}

variable "service_plan_sku" {
  type        = string
  description = "Service plan sku"
}

variable "service_name_webApp" {
  type        = string
  description = "App service name"
}

variable "repository_url" {
  type        = string
  description = "Repository url"
}

variable "repository_branch" {
  type        = string
  description = "Repository branch"
}

variable "sql_server_name" {
  type        = string
  description = "Sql server name"
}

variable "sql_server_version" {
  type        = string
  description = "Sql server version"
}

variable "sql_login" {
  type        = string
  description = "Sql_login"
}

variable "sql_password" {
  type        = string
  description = "Sql_password"
}

variable "sql_database_name" {
  type        = string
  description = "Sql database name"
}

variable "sql_database_collation" {
  type        = string
  description = "Sql database collation"
}

variable "sql_database_license_type" {
  type        = string
  description = "Sql database license type"
}

variable "sql_database_size" {
  type        = number
  description = "Sql database max size gb"
}

variable "sql_database_sku" {
  type        = string
  description = "Sql database sku name"
}

variable "firewall_name" {
  type        = string
  description = "Firewall name"
}

variable "firewall_start" {
  type        = string
  description = "Firewall start ip"
}

variable "firewall_end" {
  type        = string
  description = "Firewall end ip"
}

