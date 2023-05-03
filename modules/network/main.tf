variable "resource_group_name" {}
variable "location" {}
variable "virtual_network_name" {}
variable "subnet_name" {}

resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "main" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

output "subnet_id" {
  value = azurerm_subnet.main.id
}
