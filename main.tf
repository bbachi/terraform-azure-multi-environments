#Create Resource Group
resource "azurerm_resource_group" "resource_group" {
  name  = var.rg-name
  location = var.location
}
 
#Create Storage account
resource "azurerm_storage_account" "storage_account" {
  name                = var.storage-account-name
  resource_group_name = azurerm_resource_group.resource_group.name
 
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
 
  static_website {
    index_document = var.index_document
  }
}
 
#Add index.html to blob storage
resource "azurerm_storage_blob" "example" {
  name                   = var.index_document
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = var.source_content
}