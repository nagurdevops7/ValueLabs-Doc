# Variables for Webapp Module

variable "webapplist" {  
  description = "Provide the names for apps"
  type = list
}

variable "image_name" {
  description = "Provide name for the docker image"
  
}

variable "existing_asp_rg" {
  description = "Name of existing resource group"
  
}

variable "existing_asp" {
  description = "Name of existing app service plan"
  
}
variable "app_settings" {
  type        = map(string)
  default     = {}
  description = "Map of App Settings."
}

variable "scm_ip_restriction" {
  type        = list(string)
  default     = []
  description = "A list of IP addresses in CIDR format specifying Access Restrictions."
}


variable "create_asp" {
  type = bool
  
}

variable "prefix" {
  type        = string
  description = "The Application prefix name"
}

variable "asp_name" {
  description = "Name of the new App Service Plan"
}

variable "env" {
  type        = string
  description = "The Environment Name of the application"
}

variable "tier" {
  type        = string
  description = "The Tier of the Webapp"
}  

variable "size" {
  type        = string
  description = "The SKU  Size of the Webapp"
}

variable "location" {
  type        = string
  description = "The location where the web app should be created."
}

variable "resource_group_name" {
  type = string
}

# variable "ip_restrictions" {
#   type        = list(string)
#   default     = []
#   description = "A list of IP addresses in CIDR format specifying Access Restrictions."
# }
