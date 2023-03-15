/*
 * # Azure Event Hub
 *
 * Azure Event Hubs is a big data streaming platform and event ingestion service.
 *
 * This module creates an Azure Event Hub Namespace, Hub and an Azure Event Hub Authorization Rule.
 * Documentation: https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-about
 */

module "names-rg" {
  source   = "../naming-standard"
  env      = var.ENVIRONMENT
  location = var.LOCATION
  sub      = var.global_settings.naming_standard.sub
}

module "names-egst" {
  source   = "../naming-standard"
  env      = var.ENVIRONMENT
  location = "global"
  sub      = var.global_settings.naming_standard.sub
}

resource "azurerm_resource_group" "rg" {
  name     = "${module.names-rg.standard["storage-account"]}-${var.storage_account_name}"
  location = var.LOCATION
  tags     = var.global_settings.tags
}

resource "azurerm_storage_account" "sa" {
  name                     = module.names-rg.standard["storage-account"]
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type

  tags = var.global_settings.tags
}
