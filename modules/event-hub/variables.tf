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

variable "event_hub_name" {
  type        = string
  description = "The name of the event hub"
}

variable "event_hub_sku" {
  type        = string
  default     = "Basic"
  description = "The SKU of the event hub"
}

variable "event_hub_auth_listen" {
  type        = bool
  default     = false
  description = "The listen permission for the event hub authorisation rule"
}

variable "event_hub_auth_send" {
  type        = bool
  default     = false
  description = "The send permission for the event hub authorisation rule"
}

variable "event_hub_auth_manage" {
  type        = bool
  default     = false
  description = "The manage permission for the event hub authorisation rule"
}
