terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "avradalievRG" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_service_plan" "avradalievSP" {
  name                = var.service_plan_name
  resource_group_name = azurerm_resource_group.avradalievRG.name
  location            = azurerm_resource_group.avradalievRG.location
  os_type             = var.service_plan_type
  sku_name            = var.service_plan_sku
}

resource "azurerm_linux_web_app" "webApp" {
  name                = var.service_name_webApp
  resource_group_name = azurerm_resource_group.avradalievRG.name
  location            = azurerm_service_plan.avradalievSP.location
  service_plan_id     = azurerm_service_plan.avradalievSP.id

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = "Data Source=tcp:${azurerm_mssql_server.mssql.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.db.name};User ID=${azurerm_mssql_server.mssql.administrator_login};Password=${azurerm_mssql_server.mssql.administrator_login_password};Trusted_Connection=False; MultipleActiveResultSets=True;"
  }

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    always_on = false
  }
}

resource "azurerm_app_service_source_control" "git" {
  app_id                 = azurerm_linux_web_app.webApp.id
  repo_url               = var.repository_url
  branch                 = var.repository_branch
  use_manual_integration = true
}

resource "azurerm_mssql_server" "mssql" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.avradalievRG.name
  location                     = azurerm_resource_group.avradalievRG.location
  version                      = var.sql_server_version
  administrator_login          = var.sql_login
  administrator_login_password = var.sql_password
}

resource "azurerm_mssql_database" "db" {
  name           = var.sql_database_name
  server_id      = azurerm_mssql_server.mssql.id
  collation      = var.sql_database_collation
  license_type   = var.sql_database_license_type
  max_size_gb    = var.sql_database_size
  sku_name       = var.sql_database_sku
  zone_redundant = false
}

resource "azurerm_mssql_firewall_rule" "firewall" {
  name             = var.firewall_name
  server_id        = azurerm_mssql_server.mssql.id
  start_ip_address = var.firewall_start
  end_ip_address   = var.firewall_end
}