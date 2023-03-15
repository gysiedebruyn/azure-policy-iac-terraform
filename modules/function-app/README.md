# Function App that will receive events from Event Grid

This module creates a Function App that will receive events from Event Grid relating to Azure Policy state changes.

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)

- <a name="provider_null"></a> [null](#provider_null) (3.1.1)

## Modules

The following Modules are called:

### <a name="module_names"></a> [names](#module_names)

Source: ../naming-standard

Version:

## Resources

The following resources are used by this module:

- [azurerm_application_insights.ai](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) (resource)
- [azurerm_linux_function_app.fa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app) (resource)
- [azurerm_log_analytics_workspace.law](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) (resource)
- [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)
- [azurerm_service_plan.asp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) (resource)
- [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) (resource)
- [null_resource.function_app_publish](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_ENVIRONMENT"></a> [ENVIRONMENT](#input_ENVIRONMENT)

Description: The deployment environment acronym to which the resources are being deployed

Type: `string`

### <a name="input_LOCATION"></a> [LOCATION](#input_LOCATION)

Description: The geo location to which the resources are being deployed

Type: `string`

### <a name="input_function_app_zip_path"></a> [function_app_zip_path](#input_function_app_zip_path)

Description: The path to the function app zip file

Type: `string`

### <a name="input_function_name"></a> [function_name](#input_function_name)

Description: The name of the function app

Type: `string`

### <a name="input_global_settings"></a> [global_settings](#input_global_settings)

Description: The global settings parsed into this module as a tfvar file from deployment

Type: `any`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_event_grid_function_id"></a> [event_grid_function_id](#output_event_grid_function_id)

Description: The resource ID for the function app
