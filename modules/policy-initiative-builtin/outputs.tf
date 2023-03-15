output "id" {
  description = "The Id of the Policy Set Definition"
  value       = data.azurerm_policy_set_definition.builtin.id
}

output "name" {
  description = "The name of the Policy Set Definition"
  value       = var.initiative_name
}

output "parameters" {
  description = "The combined parameters of the Policy Set Definition"
  value       = data.azurerm_policy_set_definition.builtin.parameters
}

output "metadata" {
  description = "The metadata of the Policy Set Definition"
  value       = data.azurerm_policy_set_definition.builtin.metadata
}

output "initiative" {
  description = "The complete Policy Initiative resource node"
  value       = data.azurerm_policy_set_definition.builtin
}
