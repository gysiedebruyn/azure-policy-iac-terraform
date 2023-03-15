locals {
  modules_folder = "${get_parent_terragrunt_dir()}/../modules//"
  module_name    = basename(get_terragrunt_dir()) # Use the module with the same name as the terragrunt folder name
}

terraform {
  source = "${local.modules_folder}${local.module_name}"

  # Force Terraform to not ask for input value if some variables are undefined.
  extra_arguments "disable_input" {
    commands  = get_terraform_commands_that_need_input()
    arguments = ["-input=false"]
  }
}

inputs = merge(
  # Include common.yaml, workload.yaml, subscription.yaml, location.yaml,
  # and module.yaml in specific order for variable precedence
  { workload = element(split("/", path_relative_to_include()), 0) },
  try(yamldecode(file(find_in_parent_folders("common.yaml"))), {}),
  try(yamldecode(file(find_in_parent_folders("environment.yaml"))), {}),
  try(yamldecode(file(find_in_parent_folders("management_group.yaml"))), {}),
  try(yamldecode(file(find_in_parent_folders("subscription.yaml"))), {}),
  try(yamldecode(file(find_in_parent_folders("location.yaml"))), {}),
  try(yamldecode(file("${path_relative_to_include()}/module.yaml")), {}),
)

remote_state {
  backend = "azurerm"
  # Get the backend configuration from the common.yaml file
  config = {
    resource_group_name  = get_env("TF_VAR_terraform_state_resource_group_name")
    storage_account_name = get_env("TF_VAR_terraform_state_storage_account_name")
    container_name       = get_env("TF_VAR_terraform_state_container_name")
    subscription_id      = get_env("TF_VAR_terraform_state_subscription_id")
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}

# Generate the provider.tf in order to pin the provider
# and pass in the subscription_id variable
generate "provider" {
  path      = "provider_override.tf"
  if_exists = "skip"
  contents  = <<EOF
terraform {
  required_version = ">= 1.2.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.45.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
EOF
}

# Generate the subscription_id.tf in order to
# declare the subscription_id variable
generate "subscription_id.tf" {
  path      = "subscription_id.tf"
  if_exists = "overwrite"
  contents  = <<EOF
variable "subscription_id" {}
EOF
}

# Generate the backend.tf in order to
# declare the `azurerm` backend for each module
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "azurerm" {}
}
EOF
}

# Generate the base data.tf in order to get the
# subscription details
generate "data" {
  path      = "data.tf"
  if_exists = "skip"
  contents  = <<EOF
data "azurerm_subscription" "current" {}
EOF
}

# Don't use the root terragrunt.hcl file directly
skip = true
