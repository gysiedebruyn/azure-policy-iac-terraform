variable "exemption_name" {
  type        = string
  description = "Name for the Policy Exemption"
}

variable "exemption_scope" {
  type        = string
  description = "Scope for the Policy Exemption"
  default     = ""
}

variable "policy_assignment_id" {
  type        = string
  description = "The ID of the policy assignment that is being exempted"
}

variable "policy_definition_reference_ids" {
  type        = list(any)
  description = "The policy definition reference ID list when the associated policy assignment is an assignment of a policy set definition"
  default     = []
}

variable "exemption_category" {
  type        = string
  description = "The policy exemption category. Possible values are Waiver or Mitigated. Defaults to Waiver"
  default     = "Waiver"

  validation {
    condition     = var.exemption_category == "Waiver" || var.exemption_category == "Mitigated"
    error_message = "Exemption category possible values are: Waiver or Mitigated."
  }
}

variable "expires_on" {
  type        = string
  description = "The expiration date and time (in UTC ISO 8601 format yyyy-MM-ddTHH:mm:ssZ) of the policy exemption"
  default     = ""
}

variable "display_name" {
  type        = string
  description = "Display name for the Policy Exemption"
}

variable "description" {
  type        = string
  description = "Description for the Policy Exemption"
}

variable "metadata" {
  type        = any
  description = "Optional policy exemption metadata. For example but not limited to; requestedBy, approvedBy, approvedOn, ticketRef, etc"
  default     = {}
}
