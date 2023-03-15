# Azure Event Hub

Azure Event Hubs is a big data streaming platform and event ingestion service.

This module creates an Azure Event Hub Namespace, Hub and an Azure Event Hub Authorization Rule.
Documentation: https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-about

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

- [azurerm_eventhub.eh](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) (resource)
- [azurerm_eventhub_namespace.eh_ns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) (resource)
- [azurerm_eventhub_namespace_authorization_rule.eh_ns_auth](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) (resource)
- [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_ENVIRONMENT"></a> [ENVIRONMENT](#input_ENVIRONMENT)

Description: The deployment environment acronym to which the resources are being deployed

Type: `string`

### <a name="input_LOCATION"></a> [LOCATION](#input_LOCATION)

Description: The geo location to which the resources are being deployed

Type: `string`

### <a name="input_event_hub_name"></a> [event_hub_name](#input_event_hub_name)

Description: The name of the event hub

Type: `string`

### <a name="input_global_settings"></a> [global_settings](#input_global_settings)

Description: The global settings parsed into this module as a tfvar file from deployment

Type: `any`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_event_hub_auth_listen"></a> [event_hub_auth_listen](#input_event_hub_auth_listen)

Description: The listen permission for the event hub authorisation rule

Type: `bool`

Default: `false`

### <a name="input_event_hub_auth_manage"></a> [event_hub_auth_manage](#input_event_hub_auth_manage)

Description: The manage permission for the event hub authorisation rule

Type: `bool`

Default: `false`

### <a name="input_event_hub_auth_send"></a> [event_hub_auth_send](#input_event_hub_auth_send)

Description: The send permission for the event hub authorisation rule

Type: `bool`

Default: `false`

### <a name="input_event_hub_sku"></a> [event_hub_sku](#input_event_hub_sku)

Description: The SKU of the event hub

Type: `string`

Default: `"Basic"`

## Outputs

The following outputs are exported:

### <a name="output_event_hub_name"></a> [event_hub_name](#output_event_hub_name)

Description: The name of the event hub

### <a name="output_event_hub_namespace_authorisation_rule_id"></a> [event_hub_namespace_authorisation_rule_id](#output_event_hub_namespace_authorisation_rule_id)

Description: The ID of the event hub namespace authorisation rule

### <a name="output_event_hub_namespace_name"></a> [event_hub_namespace_name](#output_event_hub_namespace_name)

Description: The name of the event hub namespace
