## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_policy_definition.def](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_policy_name"></a> [policy_name](#input_policy_name)

Description: Name to be used for this policy, this should correspond to the correct category folder under /policies/policy_category/policy_name. Changing this forces a new resource to be created.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_display_name"></a> [display_name](#input_display_name)

Description: Display Name to be used for this policy

Type: `string`

Default: `""`

### <a name="input_management_group"></a> [management_group](#input_management_group)

Description: The management group scope at which the policy will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. Note: if you are using azurerm_management_group to assign a value to management_group_id, be sure to use name or group_id attribute, but not id.

Type: `string`

Default: `null`

### <a name="input_policy_category"></a> [policy_category](#input_policy_category)

Description: The category of the policy, should correspond to the correct category folder under /policies/var.policy_category

Type: `string`

Default: `""`

### <a name="input_policy_description"></a> [policy_description](#input_policy_description)

Description: Policy definition description

Type: `string`

Default: `""`

### <a name="input_policy_metadata"></a> [policy_metadata](#input_policy_metadata)

Description: The metadata for the policy definition. This is a JSON object representing additional metadata that should be stored with the policy definition. Omitting this will merge var.policy_category and var.policy_version as the metadata

Type: `any`

Default: `null`

### <a name="input_policy_mode"></a> [policy_mode](#input_policy_mode)

Description: The policy mode that allows you to specify which resource types will be evaluated, defaults to All. Possible values are All, Indexed, Microsoft.ContainerService.Data, Microsoft.CustomerLockbox.Data, Microsoft.DataCatalog.Data, Microsoft.KeyVault.Data, Microsoft.Kubernetes.Data, Microsoft.MachineLearningServices.Data, Microsoft.Network.Data and Microsoft.Synapse.Data

Type: `string`

Default: `"All"`

### <a name="input_policy_parameters"></a> [policy_parameters](#input_policy_parameters)

Description: Parameters for the policy definition. This field is a JSON object that allows you to parameterise your policy definition. Omitting this assumes the parameters are located in /policies/var.policy_category/var.policy_name.json

Type: `any`

Default: `null`

### <a name="input_policy_rule"></a> [policy_rule](#input_policy_rule)

Description: The policy rule for the policy definition. This is a JSON object representing the rule that contains an if and a then block. Omitting this assumes the rules are located in /policies/var.policy_category/var.policy_name.json

Type: `any`

Default: `null`

### <a name="input_policy_version"></a> [policy_version](#input_policy_version)

Description: The version for this policy, defaults to 1.0.0

Type: `string`

Default: `"1.0.0"`

### <a name="input_repo_root"></a> [repo_root](#input_repo_root)

Description: The root of the repository

Type: `string`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_definition"></a> [definition](#output_definition)

Description: The complete resource node of the Policy Definition

### <a name="output_id"></a> [id](#output_id)

Description: The Id of the Policy Definition

### <a name="output_metadata"></a> [metadata](#output_metadata)

Description: The metadata of the Policy Definition

### <a name="output_name"></a> [name](#output_name)

Description: The name of the Policy Definition

### <a name="output_parameters"></a> [parameters](#output_parameters)

Description: The parameters of the Policy Definition

### <a name="output_rules"></a> [rules](#output_rules)

Description: The rules of the Policy Definition
