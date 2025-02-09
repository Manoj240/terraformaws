variable "ARM_SUBSCRIPTION_ID" {
  description = "The Azure Subscription ID"
  type        = string
}

variable "ARM_CLIENT_ID" {
  description = "The Azure Client ID"
  type        = string
}

variable "ARM_CLIENT_SECRET" {
  description = "The Azure Client Secret"
  type        = string
}

variable "ARM_TENANT_ID" {
  description = "The Azure Tenant ID"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "manojrg"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "South India"
}