provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_key_vault" "kv" {
  name                        = "examplekeyvault"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  soft_delete_enabled         = true
  purge_protection_enabled    = false

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    secret_permissions = [
      "get",
      "list",
      "set",
      "delete",
    ]
  }
}

variable "tenant_id" {}
variable "object_id" {}

