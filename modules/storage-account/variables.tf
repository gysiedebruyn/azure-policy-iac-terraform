# ----------------------------------------------------------------------------------------------------------------------
# Module variables
# ----------------------------------------------------------------------------------------------------------------------
variable "ENVIRONMENT" {
  type        = string
  description = "The deployment environment acronym to which the resources are being deployed"
}

variable "LOCATION" {
  type        = string
  description = "The geo location to which the resources are being deployed"
}

variable "global_settings" {
  type        = any
  description = "The global settings parsed into this module as a tfvar file from deployment"
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account"
}

variable "storage_account_tier" {
  type        = string
  default     = "Standard"
  description = "The SKU of the storage account"
}

variable "storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "The replication type of the storage account"
}
