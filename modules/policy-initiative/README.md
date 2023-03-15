## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_policy_set_definition.set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_initiative_display_name"></a> [initiative_display_name](#input_initiative_display_name)

Description: Policy initiative display name

Type: `string`

### <a name="input_initiative_name"></a> [initiative_name](#input_initiative_name)

Description: Policy initiative name. Changing this forces a new resource to be created

Type: `string`

### <a name="input_member_definitions"></a> [member_definitions](#input_member_definitions)

Description: Policy Defenition resource nodes that will be members of this initiative

Type: `any`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_initiative_category"></a> [initiative_category](#input_initiative_category)

Description: The category of the initiative

Type: `string`

Default: `"General"`

### <a name="input_initiative_description"></a> [initiative_description](#input_initiative_description)

Description: Policy initiative description

Type: `string`

Default: `""`

### <a name="input_initiative_version"></a> [initiative_version](#input_initiative_version)

Description: The version for this initiative, defaults to 1.0.0

Type: `string`

Default: `"1.0.0"`

### <a name="input_management_group"></a> [management_group](#input_management_group)

Description: The management group scope at which the initiative will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. Note: if you are using azurerm_management_group to assign a value to management_group_id, be sure to use name or group_id attribute, but not id.

Type: `string`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_id"></a> [id](#output_id)

Description: The Id of the Policy Set Definition

### <a name="output_initiative"></a> [initiative](#output_initiative)

Description: The complete Policy Initiative resource node

### <a name="output_metadata"></a> [metadata](#output_metadata)

Description: The metadata of the Policy Set Definition

### <a name="output_name"></a> [name](#output_name)

Description: The name of the Policy Set Definition

### <a name="output_parameters"></a> [parameters](#output_parameters)

Description: The combined parameters of the Policy Set Definition

### <a name="output_role_definition_ids"></a> [role_definition_ids](#output_role_definition_ids)

Description: Role definition IDs for remediation
