terraform {

  required_version = ">=0.12"
  required_providers {

    azurerm = {

      source = "hashicorp/azurerm"

      version = "~>2.0"

    }

  }

  backend "azurerm" {

  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
  subscription_id = "3a6fd034-c5f3-4201-9c86-473f1eb586f4"

}
