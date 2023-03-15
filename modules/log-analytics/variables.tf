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

variable "la_workspace_name" {
  type        = string
  description = "The name of the Azure Log Analytics workspace"
}

variable "law_sku" {
  type        = string
  description = "The Azure Log Analytics workspace SKU"
  default     = "PerGB2018"
}

variable "law_retention_in_days" {
  type        = string
  description = "The Azure Log Analytics workspace retention in days"
  default     = "30"
}

variable "law_daily_quota_gb" {
  type        = string
  default     = "0.5"
  description = "(Optional) The workspace daily quota for ingestion in GB. Defaults to 0.5 (unlimited) if omitted."
}
