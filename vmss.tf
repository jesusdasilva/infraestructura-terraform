variable "resource_group_name" {}
variable "location" {}
variable "vmss_name" {}
variable "subnet_id" {}
variable "loadbalancer_id" {}

resource "azurerm_windows_virtual_machine_scale_set" "main" {
  name                = var.vmss_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard_F2"
  instances           = 2

  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd1234!"

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  data_disk {
    lun                  = 0
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 32
  }

  upgrade_mode = "Manual"

  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name      = "vmss-ip-config"
      primary   = true
      subnet_id = var.subnet_id

      load_balancer_backend_address_pool_ids = [
        azurerm_lb_backend_address_pool.main.id,
      ]
    }
  }

  depends_on = [
    azurerm_lb_backend_address_pool.main,
  ]
}

resource "azurerm_lb_backend_address_pool" "main" {
  loadbalancer_id = var.loadbalancer_id
  name            = "vmss-backend-pool"
}
