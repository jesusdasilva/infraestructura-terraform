variable "resource_group_name" {}
variable "location" {}
variable "mysql_server_name" {}

resource "azurerm_mysql_server" "main" {
  name                = var.mysql_server_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = "GP_Gen5_2"

  storage_mb = 5120
  backup_retention_days = 7
  geo_redundant_backup_enabled = true

  administrator_login          = "mysqladmin"
  administrator_login_password = "P@ssw0rd1234!"

  version = "5.7"

  ssl_enforcement_enabled = true
}

resource "azurerm_mysql_firewall_rule" "main" {
  name                = "AllowAllWindowsAzureIps"
  resource_group_name = azurerm_mysql_server.main.resource_group_name
  server_name         = azurerm_mysql_server.main.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
