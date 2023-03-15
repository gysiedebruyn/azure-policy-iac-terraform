# Azure Policy State Changes Event Grid System Topic

This modules creates a system topic in the Azure Event Grid service that only monitors
Azure Policy state changes.

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)

## Modules

The following Modules are called:

### <a name="module_names-egst"></a> [names-egst](#module_names-egst)

Source: ../naming-standard

Version:

### <a name="module_names-rg"></a> [names-rg](#module_names-rg)

Source: ../naming-standard

Version:

## Resources

The following resources are used by this module:

- [azurerm_eventgrid_system_topic.policy_state](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic) (resource)
- [azurerm_eventgrid_system_topic_event_subscription.policy_state](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic_event_subscription) (resource)
- [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_ENVIRONMENT"></a> [ENVIRONMENT](#input_ENVIRONMENT)

Description: The deployment environment acronym to which the resources are being deployed

Type: `string`

### <a name="input_LOCATION"></a> [LOCATION](#input_LOCATION)

Description: The geo location to which the resources are being deployed

Type: `string`

### <a name="input_eventgrid_name"></a> [eventgrid_name](#input_eventgrid_name)

Description: The name of the event grid system topic

Type: `string`

### <a name="input_function_id"></a> [function_id](#input_function_id)

Description: The resource ID of the function to be invoked by the event grid system topic

Type: `string`

### <a name="input_global_settings"></a> [global_settings](#input_global_settings)

Description: The global settings parsed into this module as a tfvar file from deployment

Type: `any`

## Optional Inputs

No optional inputs.

## Outputs

No outputs.
