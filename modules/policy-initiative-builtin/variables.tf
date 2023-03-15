variable "management_group_name" {
  type        = string
  description = "The management group scope at which the initiative is defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created."
  default     = null
}

variable "initiative_name" {
  type        = string
  description = "Name of the built-in Azure Policy Initiative Definition"
}
