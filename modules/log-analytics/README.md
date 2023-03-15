# Azure Policy Log Analytics Workspace

This module creates a Log Analytics Workspace that will form as the collection point for the alerts and triggers.

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)

## Modules

The following Modules are called:

### <a name="module_names"></a> [names](#module_names)

Source: ../naming-standard

Version:

## Resources

The following resources are used by this module:

- [azurerm_log_analytics_workspace.law](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) (resource)
- [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)

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

### <a name="input_la_workspace_name"></a> [la_workspace_name](#input_la_workspace_name)

Description: The name of the Azure Log Analytics workspace

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_law_daily_quota_gb"></a> [law_daily_quota_gb](#input_law_daily_quota_gb)

Description: (Optional) The workspace daily quota for ingestion in GB. Defaults to 0.5 (unlimited) if omitted.

Type: `string`

Default: `"0.5"`

### <a name="input_law_retention_in_days"></a> [law_retention_in_days](#input_law_retention_in_days)

Description: The Azure Log Analytics workspace retention in days

Type: `string`

Default: `"30"`

### <a name="input_law_sku"></a> [law_sku](#input_law_sku)

Description: The Azure Log Analytics workspace SKU

Type: `string`

Default: `"PerGB2018"`

## Outputs

The following outputs are exported:

### <a name="output_id"></a> [id](#output_id)

Description: The Log Analytics Workspace ID

### <a name="output_law_id"></a> [law_id](#output_law_id)

Description: The Workspace (or Customer) ID for the Log Analytics Workspace
