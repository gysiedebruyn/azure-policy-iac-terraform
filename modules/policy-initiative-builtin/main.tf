data "azurerm_policy_set_definition" "builtin" {
  display_name          = var.initiative_name
  management_group_name = var.management_group_name
}
