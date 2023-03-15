## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_resource_policy_exemption.exemption](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_exemption) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_description"></a> [description](#input_description)

Description: Description for the Policy Exemption

Type: `string`

### <a name="input_display_name"></a> [display_name](#input_display_name)

Description: Display name for the Policy Exemption

Type: `string`

### <a name="input_exemption_name"></a> [exemption_name](#input_exemption_name)

Description: Name for the Policy Exemption

Type: `string`

### <a name="input_policy_assignment_id"></a> [policy_assignment_id](#input_policy_assignment_id)

Description: The ID of the policy assignment that is being exempted

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_exemption_category"></a> [exemption_category](#input_exemption_category)

Description: The policy exemption category. Possible values are Waiver or Mitigated. Defaults to Waiver

Type: `string`

Default: `"Waiver"`

### <a name="input_exemption_scope"></a> [exemption_scope](#input_exemption_scope)

Description: Scope for the Policy Exemption

Type: `string`

Default: `""`

### <a name="input_expires_on"></a> [expires_on](#input_expires_on)

Description: The expiration date and time (in UTC ISO 8601 format yyyy-MM-ddTHH:mm:ssZ) of the policy exemption

Type: `string`

Default: `""`

### <a name="input_metadata"></a> [metadata](#input_metadata)

Description: Optional policy exemption metadata. For example but not limited to; requestedBy, approvedBy, approvedOn, ticketRef, etc

Type: `any`

Default: `{}`

### <a name="input_policy_definition_reference_ids"></a> [policy_definition_reference_ids](#input_policy_definition_reference_ids)

Description: The policy definition reference ID list when the associated policy assignment is an assignment of a policy set definition

Type: `list(any)`

Default: `[]`

## Outputs

The following outputs are exported:

### <a name="output_id"></a> [id](#output_id)

Description: The Id of the Policy Exemption
