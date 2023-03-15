/*
 * # Azure Policy State Changes Event Grid System Topic
 *
 * This modules creates a system topic in the Azure Event Grid service that only monitors
 * Azure Policy state changes.
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
  name     = "${module.names-rg.standard["resource-group"]}-${var.eventgrid_name}"
  location = var.LOCATION
  tags     = var.global_settings.tags
}

resource "azurerm_eventgrid_system_topic" "policy_state" {
  name                   = "${module.names-egst.standard["event-grid-system-topic"]}-${var.eventgrid_name}"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = "global"
  source_arm_resource_id = data.azurerm_subscription.current.id
  topic_type             = "Microsoft.PolicyInsights.PolicyStates"
}

resource "azurerm_eventgrid_system_topic_event_subscription" "policy_state" {
  name                                 = "${module.names-egst.standard["event-grid-system-topic-event-subscription"]}-${var.eventgrid_name}"
  system_topic                         = azurerm_eventgrid_system_topic.policy_state.name
  resource_group_name                  = azurerm_resource_group.rg.name
  event_delivery_schema                = "EventGridSchema"
  advanced_filtering_on_arrays_enabled = true

  included_event_types = [
    "Microsoft.PolicyInsights.PolicyStateCreated",
    "Microsoft.PolicyInsights.PolicyStateChanged",
    "Microsoft.PolicyInsights.PolicyStateDeleted"
  ]

  azure_function_endpoint {
    function_id                       = var.function_id
    max_events_per_batch              = 1
    preferred_batch_size_in_kilobytes = 64
  }
}
