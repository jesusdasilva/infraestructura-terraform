variable "resource_group_name" {}
variable "location" {}
variable "key_vault_name" {}

resource "azurerm_key_vault" "main" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = "standard"

  tenant_id = data.azurerm_client_config.current.tenant_id

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "create",
      "get",
      "list",
      "delete",
      "recover",
      "backup",
      "restore",
    ]

    secret_permissions = [
      "set",
      "get",
      "delete",
      "list",
      "recover",
      "backup",
      "restore",
    ]

    certificate_permissions = [
      "create",
      "delete",
      "deleteissuers",
      "get",
      "getissuers",
      "import",
      "list",
      "listissuers",
      "managecontacts",
      "manageissuers",
      "setissuers",
      "update",
    ]
  }

  tags = {
    environment = "Production"
  }
}

data "azurerm_client_config" "current" {}
