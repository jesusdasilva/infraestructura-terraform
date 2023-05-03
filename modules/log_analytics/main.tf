variable "resource_group_name" {}
variable "location" {}
variable "log_analytics_name" {}

resource "azurerm_log_analytics_workspace" "main" {
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.main.id
}

output "log_analytics_primary_shared_key" {
  value = azurerm_log_analytics_workspace.main.primary_shared_key
}
