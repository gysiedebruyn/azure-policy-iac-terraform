
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

variable "function_name" {
  type        = string
  description = "The name of the function app"
}

variable "global_settings" {
  type        = any
  description = "The global settings parsed into this module as a tfvar file from deployment"
}

variable "function_app_zip_path" {
  type        = string
  description = "The path to the function app zip file"
}
