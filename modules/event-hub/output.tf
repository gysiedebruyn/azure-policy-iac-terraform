output "event_hub_namespace_name" {
  value       = azurerm_eventhub_namespace.eh_ns.name
  description = "The name of the event hub namespace"
}

output "event_hub_name" {
  value       = azurerm_eventhub.eh.name
  description = "The name of the event hub"
}

output "event_hub_namespace_authorisation_rule_id" {
  value       = azurerm_eventhub_namespace_authorization_rule.eh_ns_auth.id
  description = "The ID of the event hub namespace authorisation rule"
}
