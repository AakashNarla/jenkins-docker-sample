
resource "azurerm_storage_account" "azure_acr_storage" {
  name                     = "nxacrstorageaccount"
  resource_group_name      = "${azurerm_resource_group.aks_demo.name}"
  location                 = "${azurerm_resource_group.aks_demo.location}"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_container_registry" "azure_acr" {
  name                = "registrynxbnsf"
  resource_group_name = "${azurerm_resource_group.aks_demo.name}"
  location            = "${azurerm_resource_group.aks_demo.location}"
  admin_enabled       = true
  sku                 = "Classic"
  storage_account_id  = "${azurerm_storage_account.azure_acr_storage.id}"
}


output "login_server" {
  value = "${azurerm_container_registry.azure_acr.login_server}"
}

output "admin_username" {
  value = "${azurerm_container_registry.azure_acr.admin_username}"
}
output "admin_password" {
  value = "${azurerm_container_registry.azure_acr.admin_password}"
}