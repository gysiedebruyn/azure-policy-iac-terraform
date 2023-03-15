/*
 * # Function App that will receive events from Event Grid
 *
 * This module creates a Function App that will receive events from Event Grid relating to Azure Policy state changes.
 */

terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

module "names" {
  source   = "../naming-standard"
  env      = var.ENVIRONMENT
  location = var.LOCATION
  sub      = var.global_settings.naming_standard.sub
}

resource "azurerm_resource_group" "rg" {
  name     = "${module.names.standard["resource-group"]}-${var.function_name}"
  location = var.LOCATION
  tags     = var.global_settings.tags
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${module.names.standard["log-analytics-workspace"]}-${var.function_name}"
  location            = var.LOCATION
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_storage_account" "sa" {
  name                      = "${module.names.standard["storage-account"]}azpolmon"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = var.LOCATION
  access_tier               = "Hot"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  enable_https_traffic_only = true
  tags                      = var.global_settings.tags
}

resource "azurerm_application_insights" "ai" {
  name                = "${module.names.standard["application-insights"]}-${var.function_name}"
  location            = var.LOCATION
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
  tags                = var.global_settings.tags
}

resource "azurerm_service_plan" "asp" {
  name                = "${module.names.standard["app-service-plan"]}-${var.function_name}"
  location            = var.LOCATION
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "Y1"
  tags                = var.global_settings.tags
}

resource "azurerm_linux_function_app" "fa" {
  name                        = "${module.names.standard["function-app"]}-${var.function_name}"
  location                    = var.LOCATION
  resource_group_name         = azurerm_resource_group.rg.name
  service_plan_id             = azurerm_service_plan.asp.id
  storage_account_name        = azurerm_storage_account.sa.name
  storage_account_access_key  = azurerm_storage_account.sa.primary_access_key
  functions_extension_version = "~4"
  tags                        = var.global_settings.tags

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "python"
    # "FUNCTIONS_EXTENSION_VERSION"    = "~3"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.ai.instrumentation_key
    "AzureWebJobsStorage"            = "DefaultEndpointsProtocol=https;AccountName=${azurerm_storage_account.sa.name};AccountKey=${azurerm_storage_account.sa.primary_access_key}"
    "WEBSITE_RUN_FROM_PACKAGE"       = ""
    "WORKSPACE_ID"                   = azurerm_log_analytics_workspace.law.workspace_id
    "WORKSPACE_KEY"                  = azurerm_log_analytics_workspace.law.primary_shared_key
  }

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"]
    ]
  }

  site_config {
    app_scale_limit = 1

    application_stack {
      python_version = "3.9"
    }
  }
}

resource "null_resource" "function_app_publish" {
  provisioner "local-exec" {
    command = "az functionapp deployment source config-zip --subscription ${data.azurerm_subscription.current.subscription_id} --resource-group ${azurerm_resource_group.rg.name} --name ${azurerm_linux_function_app.fa.name} --src ${var.function_app_zip_path}"
  }

  triggers = {
    input_json           = filemd5(var.function_app_zip_path)
    publish_code_command = "az functionapp deployment source config-zip --subscription ${data.azurerm_subscription.current.subscription_id} --resource-group ${azurerm_resource_group.rg.name} --name ${azurerm_linux_function_app.fa.name} --src ${var.function_app_zip_path}"
  }

  depends_on = [
    azurerm_linux_function_app.fa,
  ]
}
