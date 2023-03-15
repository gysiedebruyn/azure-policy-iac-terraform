resource "azurerm_resource_policy_exemption" "exemption" {
  name                            = var.exemption_name
  resource_id                     = var.exemption_scope
  policy_assignment_id            = var.policy_assignment_id
  exemption_category              = var.exemption_category
  policy_definition_reference_ids = var.policy_definition_reference_ids
  expires_on                      = var.expires_on != "" ? var.expires_on : null
  display_name                    = var.display_name
  description                     = var.description
  metadata                        = jsonencode(var.metadata)
}
