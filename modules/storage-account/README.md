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

- [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)
- [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_ENVIRONMENT"></a> [ENVIRONMENT](#input_ENVIRONMENT)

Description: The deployment environment acronym to which the resources are being deployed

Type: `string`

### <a name="input_LOCATION"></a> [LOCATION](#input_LOCATION)

Description: The geo location to which the resources are being deployed

Type: `string`

### <a name="input_global_settings"></a> [global_settings](#input_global_settings)

Description: The global settings parsed into this module as a tfvar file from deployment

Type: `any`

### <a name="input_storage_account_name"></a> [storage_account_name](#input_storage_account_name)

Description: The name of the storage account

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_storage_account_replication_type"></a> [storage_account_replication_type](#input_storage_account_replication_type)

Description: The replication type of the storage account

Type: `string`

Default: `"LRS"`

### <a name="input_storage_account_tier"></a> [storage_account_tier](#input_storage_account_tier)

Description: The SKU of the storage account

Type: `string`

Default: `"Standard"`

## Outputs

The following outputs are exported:

### <a name="output_storage_account_id"></a> [storage_account_id](#output_storage_account_id)

Description: The resource ID for the storage account
