#!/bin/bash
set -euo pipefail

# Check to see if the RG exists, if not create it
if az group show --name ${TF_VAR_terraform_state_resource_group_name} --subscription ${TF_VAR_terraform_state_subscription_id} | jq '.id' > /dev/null; then
    echo "Resource ${TF_VAR_terraform_state_resource_group_name} group exists. Skipping creation ..."
else
    echo "Creating the Terraform state storage resource group ... ${TF_VAR_terraform_state_resource_group_name}"
    az group create --name ${TF_VAR_terraform_state_resource_group_name} --location ${AZURE_DEFAULT_LOCATION} --subscription ${TF_VAR_terraform_state_subscription_id}
fi

# The RG exists, now create storage account
if az storage account show --name ${TF_VAR_terraform_state_storage_account_name} --subscription ${TF_VAR_terraform_state_subscription_id} --resource-group ${TF_VAR_terraform_state_resource_group_name} | jq '.id' > /dev/null; then
    echo "Terraform state storage account ${TF_VAR_terraform_state_storage_account_name} exists. Skipping creation ..."
else
    echo "Creating the Terraform state storage account ... ${TF_VAR_terraform_state_storage_account_name}"
    az storage account create --name ${TF_VAR_terraform_state_storage_account_name} --subscription ${TF_VAR_terraform_state_subscription_id} --resource-group ${TF_VAR_terraform_state_resource_group_name}
fi

# The storage account exists, now create the container
TERRAFORM_STATE_CONNECTION_STRING=$(az storage account show-connection-string --subscription ${TF_VAR_terraform_state_subscription_id} --resource-group ${TF_VAR_terraform_state_resource_group_name} --name ${TF_VAR_terraform_state_storage_account_name} --query "connectionString" --output tsv)
if az storage container show --subscription ${TF_VAR_terraform_state_subscription_id} --name ${TF_VAR_terraform_state_container_name} --connection-string=${TERRAFORM_STATE_CONNECTION_STRING} | jq '.id' > /dev/null; then
    echo "Terraform state storage account container ${TF_VAR_terraform_state_container_name} exists. Skipping creation ..."
else
    echo "Creating the Terraform state storage account container ... ${TF_VAR_terraform_state_container_name}"
    az storage container create --subscription ${TF_VAR_terraform_state_subscription_id} --name ${TF_VAR_terraform_state_container_name} --connection-string=${TERRAFORM_STATE_CONNECTION_STRING}
fi
