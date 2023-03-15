resource "azurerm_management_group_policy_assignment" "set" {
  count = local.assignment_scope.mg

  name                 = local.assignment_name
  display_name         = local.display_name
  description          = local.description
  management_group_id  = var.assignment_scope
  not_scopes           = var.assignment_not_scopes
  enforce              = var.assignment_enforcement_mode
  policy_definition_id = var.initiative.id
  parameters           = local.parameters
  location             = var.assignment_location

  dynamic "identity" {
    for_each = local.identity_type
    content {
      type = identity.value
    }
  }
}

resource "azurerm_subscription_policy_assignment" "set" {
  count = local.assignment_scope.sub

  name                 = local.assignment_name
  display_name         = local.display_name
  description          = local.description
  subscription_id      = var.assignment_scope
  not_scopes           = var.assignment_not_scopes
  enforce              = var.assignment_enforcement_mode
  policy_definition_id = var.initiative.id
  parameters           = local.parameters
  location             = var.assignment_location

  dynamic "identity" {
    for_each = local.identity_type
    content {
      type = identity.value
    }
  }
}


resource "azurerm_resource_group_policy_assignment" "set" {
  count = local.assignment_scope.rg

  name                 = local.assignment_name
  display_name         = local.display_name
  description          = local.description
  resource_group_id    = var.assignment_scope
  not_scopes           = var.assignment_not_scopes
  enforce              = var.assignment_enforcement_mode
  policy_definition_id = var.initiative.id
  parameters           = local.parameters
  location             = var.assignment_location

  dynamic "identity" {
    for_each = local.identity_type
    content {
      type = identity.value
    }
  }
}

resource "azurerm_resource_policy_assignment" "set" {
  count = local.assignment_scope.resource

  name                 = local.assignment_name
  display_name         = local.display_name
  description          = local.description
  resource_id          = var.assignment_scope
  not_scopes           = var.assignment_not_scopes
  enforce              = var.assignment_enforcement_mode
  policy_definition_id = var.initiative.id
  parameters           = local.parameters
  location             = var.assignment_location

  dynamic "identity" {
    for_each = local.identity_type
    content {
      type = identity.value
    }
  }
}

resource "azurerm_role_assignment" "rem_role" {
  for_each = toset(local.role_definition_ids)

  scope                            = local.role_assignment_scope
  role_definition_id               = each.value
  principal_id                     = local.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_management_group_policy_remediation" "rem_mg" {
  for_each = local.create_remediation ? local.assignment_scope.mg == 1 ? local.policy_definition_ids : [] : []

  name                           = "${local.assignment_name}remediation"
  management_group_id            = var.assignment_scope
  policy_assignment_id           = local.assignment_id
  location_filters               = var.location_filters
  policy_definition_reference_id = each.value

  depends_on = [azurerm_role_assignment.rem_role]
}

resource "azurerm_subscription_policy_remediation" "rem_sub" {
  for_each = local.create_remediation ? local.assignment_scope.sub == 1 ? local.policy_definition_ids : [] : []

  name                           = "${local.assignment_name}remediation"
  subscription_id                = var.assignment_scope
  policy_assignment_id           = local.assignment_id
  location_filters               = var.location_filters
  policy_definition_reference_id = each.key

  depends_on = [azurerm_role_assignment.rem_role]
}

resource "azurerm_resource_group_policy_remediation" "rem_rg" {
  for_each = local.create_remediation ? local.assignment_scope.rg == 1 ? local.policy_definition_ids : [] : []

  name                           = "${local.assignment_name}remediation"
  resource_group_id              = var.assignment_scope
  policy_assignment_id           = local.assignment_id
  location_filters               = var.location_filters
  policy_definition_reference_id = each.key

  depends_on = [azurerm_role_assignment.rem_role]
}

resource "azurerm_resource_policy_remediation" "rem_resource" {
  for_each = local.create_remediation ? local.assignment_scope.resource == 1 ? local.policy_definition_ids : [] : []

  name                           = "${local.assignment_name}remediation"
  resource_id                    = var.assignment_scope
  policy_assignment_id           = local.assignment_id
  location_filters               = var.location_filters
  policy_definition_reference_id = each.key

  depends_on = [azurerm_role_assignment.rem_role]
}
