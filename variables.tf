variable "r_prefix" {
  type        = string
  description = "Prefix for the application names"

}

variable "r_env" {
  type        = string
  description = "Set the environment name like prod, dev, qa, uat or DR"

}

variable "r_location" {
  type        = string
  description = "You should provide an Azure location for your resources"
  default     = "northeurope"
}

variable "r_create_asp_linux" {
  type        = bool
  description = "Set this to false to use the existing app service plan for Linux (V2) apps"
}

#####################################################################################################
# The following are mandatory values when new resources are built on top of existing infrastructure.#
#####################################################################################################


variable "r_existing_aspl" {
  type        = string
  description = "Give the name of the existing Linux App Service plan, only if the 'r_create_asp_linux' is set to false"

}

variable "r_existing_aspl_rg" {
  type        = string
  description = "Give the name of the Resource group for r_existing_aspl, if the 'r_create_asp_linux' is set to false"

}

variable "r_app_names" {
  type = list(any)

}
