variable "resource_group_name" {}
variable "location" {}
variable "lb_name" {}
variable "public_ip_name" {}

resource "azurerm_public_ip" "main" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_lb" "main" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

output "lb_id" {
  value = azurerm_lb.main.id
}
