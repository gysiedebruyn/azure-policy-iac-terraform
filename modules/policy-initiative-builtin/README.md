## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_policy_set_definition.builtin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_set_definition) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_initiative_name"></a> [initiative_name](#input_initiative_name)

Description: Name of the built-in Azure Policy Initiative Definition

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_management_group_name"></a> [management_group_name](#input_management_group_name)

Description: The management group scope at which the initiative is defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created.

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
