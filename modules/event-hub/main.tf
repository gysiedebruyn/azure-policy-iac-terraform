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
  name     = "${module.names-rg.standard["resource-group"]}-${var.event_hub_name}"
  location = var.LOCATION
  tags     = var.global_settings.tags
}

resource "azurerm_eventhub_namespace" "eh_ns" {
  name                = "${module.names-rg.standard["event-hub-namespace"]}-${var.event_hub_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.event_hub_sku
  capacity            = 1

  tags = var.global_settings.tags
}

resource "azurerm_eventhub" "eh" {
  name                = "${module.names-rg.standard["event-hub"]}-${var.event_hub_name}"
  namespace_name      = azurerm_eventhub_namespace.eh_ns.name
  resource_group_name = azurerm_resource_group.rg.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_namespace_authorization_rule" "eh_ns_auth" {
  name                = "${module.names-rg.standard["eventhub_namespace_authorization_rule"]}-${var.event_hub_name}"
  namespace_name      = azurerm_eventhub_namespace.eh_ns.name
  resource_group_name = azurerm_resource_group.rg.name
  listen              = var.event_hub_auth_listen
  send                = var.event_hub_auth_send
  manage              = var.event_hub_auth_manage
}
