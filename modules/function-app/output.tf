output "event_grid_function_id" {
  value       = "${azurerm_linux_function_app.fa.id}/functions/eventgrid_handler"
  description = "The resource ID for the function app"
}
