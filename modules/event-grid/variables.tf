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

variable "eventgrid_name" {
  type        = string
  description = "The name of the event grid system topic"
}

variable "function_id" {
  type        = string
  description = "The resource ID of the function to be invoked by the event grid system topic"
}

variable "global_settings" {
  type        = any
  description = "The global settings parsed into this module as a tfvar file from deployment"
}
