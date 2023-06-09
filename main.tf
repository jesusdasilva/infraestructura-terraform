provider "azurerm" {
  features {}
}

locals {
  resource_group_name   = "myResourceGroup"
  location              = "East US"
  virtual_network_name  = "myVirtualNetwork"
  subnet_name           = "mySubnet"
  lb_name               = "myLoadBalancer"
  vmss_name             = "myVmss"
  app_gateway_name      = "myAppGateway"
  mysql_server_name     = "myMysqlServer"
  key_vault_name        = "myKeyVault"
  public_ip_name        = "myPublicIP"
  log_analytics_name    = "myLogAnalytics"
}

resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = local.location
}

module "network" {
  source              = "./network.tf"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  virtual_network_name  = local.virtual_network_name
  subnet_name           = local.subnet_name
}

module "loadbalancer" {
  source              = "./loadbalancer.tf"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  lb_name             = local.lb_name
  public_ip_name      = local.public_ip_name
}

module "vmss" {
  source              = "./vmss.tf"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  vmss_name           = local.vmss_name
  subnet_id           = module.network.subnet_id
  loadbalancer_id     = module.loadbalancer.lb_id
}

module "app_gateway" {
  source              = "./app_gateway.tf"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  app_gateway_name    = local.app_gateway_name
  subnet_id           = module.network.subnet_id
}

module "mysql_server" {
  source              = "./mysql_server.tf"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  mysql_server_name   = local.mysql_server_name
}

module "key_vault" {
  source              = "./key_vault.tf"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  key_vault_name      = local.key_vault_name
}

module "log_analytics" {
  source              = "./log_analytics.tf"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  log_analytics_name  = local.log_analytics_name
}
