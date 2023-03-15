output "id" {
  value       = azurerm_log_analytics_workspace.law.id
  description = "The Log Analytics Workspace ID"
}

output "law_id" {
  value       = azurerm_log_analytics_workspace.law.workspace_id
  description = "The Workspace (or Customer) ID for the Log Analytics Workspace"
}
