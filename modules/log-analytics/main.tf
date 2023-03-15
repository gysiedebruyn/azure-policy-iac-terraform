/*
 * # Azure Policy Log Analytics Workspace
 *
 * This module creates a Log Analytics Workspace that will form as the collection point for the alerts and triggers.
 */

module "names" {
  source   = "../naming-standard"
  env      = var.ENVIRONMENT
  location = var.LOCATION
  sub      = var.global_settings.naming_standard.sub
}

resource "azurerm_resource_group" "rg" {
  name     = "${module.names.standard["resource-group"]}-${var.la_workspace_name}"
  location = var.LOCATION
  tags     = var.global_settings.tags
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${module.names.standard["log-analytics-workspace"]}-${var.la_workspace_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_in_days
  daily_quota_gb      = var.law_daily_quota_gb
}
