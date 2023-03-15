## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_management_group_policy_assignment.def](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) (resource)
- [azurerm_management_group_policy_remediation.rem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_remediation) (resource)
- [azurerm_resource_group_policy_assignment.def](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_assignment) (resource)
- [azurerm_resource_group_policy_remediation.rem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_remediation) (resource)
- [azurerm_resource_policy_assignment.def](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_assignment) (resource)
- [azurerm_resource_policy_remediation.rem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_remediation) (resource)
- [azurerm_role_assignment.rem_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_subscription_policy_assignment.def](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) (resource)
- [azurerm_subscription_policy_remediation.rem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_remediation) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_assignment_scope"></a> [assignment_scope](#input_assignment_scope)

Description: The scope at which the policy will be assigned. Must be full resource IDs. Changing this forces a new resource to be created

Type: `string`

### <a name="input_definition"></a> [definition](#input_definition)

Description: Policy Definition resource node

Type: `any`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_assignment_description"></a> [assignment_description](#input_assignment_description)

Description: A description to use for the Policy Assignment, defaults to definition description. Changing this forces a new resource to be created

Type: `string`

Default: `""`

### <a name="input_assignment_display_name"></a> [assignment_display_name](#input_assignment_display_name)

Description: The policy assignment display name, defaults to definition display_name. Changing this forces a new resource to be created

Type: `string`

Default: `""`

### <a name="input_assignment_effect"></a> [assignment_effect](#input_assignment_effect)

Description: The effect of the policy. Changing this forces a new resource to be created

Type: `string`

Default: `null`

### <a name="input_assignment_enforcement_mode"></a> [assignment_enforcement_mode](#input_assignment_enforcement_mode)

Description: Control whether the assignment is enforced

Type: `bool`

Default: `true`

### <a name="input_assignment_location"></a> [assignment_location](#input_assignment_location)

Description: The Azure location where this policy assignment should exist, required when an Identity is assigned. Defaults to Australia East. Changing this forces a new resource to be created

Type: `string`

Default: `"australiaeast"`

### <a name="input_assignment_name"></a> [assignment_name](#input_assignment_name)

Description: The name which should be used for this Policy Assignment, defaults to definition name. Changing this forces a new Policy Assignment to be created

Type: `string`

Default: `""`

### <a name="input_assignment_not_scopes"></a> [assignment_not_scopes](#input_assignment_not_scopes)

Description: A list of the Policy Assignment's excluded scopes. Must be full resource IDs

Type: `list(any)`

Default: `[]`

### <a name="input_assignment_parameters"></a> [assignment_parameters](#input_assignment_parameters)

Description: The policy assignment parameters. Changing this forces a new resource to be created

Type: `any`

Default: `null`

### <a name="input_location_filters"></a> [location_filters](#input_location_filters)

Description: Optional list of the resource locations that will be remediated

Type: `list(any)`

Default: `[]`

### <a name="input_resource_discovery_mode"></a> [resource_discovery_mode](#input_resource_discovery_mode)

Description: The way that resources to remediate are discovered. Possible values are ExistingNonCompliant or ReEvaluateCompliance. Defaults to ExistingNonCompliant.

Type: `string`

Default: `"ExistingNonCompliant"`

### <a name="input_role_assignment_scope"></a> [role_assignment_scope](#input_role_assignment_scope)

Description: The scope at which role definition(s) will be assigned, defaults to Policy Assignment Scope. Must be full resource IDs. Changing this forces a new resource to be created

Type: `string`

Default: `null`

### <a name="input_role_definition_ids"></a> [role_definition_ids](#input_role_definition_ids)

Description: List of Role definition ID's for the System Assigned Identity, defaults to roles included in the definition. Specify a blank array to skip creating role assignments. Changing this forces a new resource to be created

Type: `list(any)`

Default: `[]`

### <a name="input_skip_remediation"></a> [skip_remediation](#input_skip_remediation)

Description: Should the module skip creation of a remediation task for policies that DeployIfNotExists and Modify

Type: `bool`

Default: `false`

### <a name="input_skip_role_assignment"></a> [skip_role_assignment](#input_skip_role_assignment)

Description: Should the module skip creation of role assignment for policies that DeployIfNotExists and Modify

Type: `bool`

Default: `false`

## Outputs

The following outputs are exported:

### <a name="output_id"></a> [id](#output_id)

Description: The Policy Assignment Id

### <a name="output_identity_id"></a> [identity_id](#output_identity_id)

Description: The Managed Identity block containing Principal Id & Tenant Id of this Policy Assignment if type is SystemAssigned

### <a name="output_role_definition_ids"></a> [role_definition_ids](#output_role_definition_ids)

Description: The List of Role Defenition Ids assignable to the managed identity
