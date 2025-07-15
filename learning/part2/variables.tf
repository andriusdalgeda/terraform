variable "location" {
  description = "resource deployment location, e.g uksouth"
  default     = "uksouth"
}

variable "resource_group_name" {
  description = "RG name"
}

variable "storage_account_name" {
  description = "max 24 chars"
}

variable "blob_source_uri" {
  description = "uri pointing to file"
}

variable "container_name" {
  description = "name of container"
}

variable "subscription_id" {
  description = "subscription id"
}