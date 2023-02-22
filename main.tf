# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}


# Create a new Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.r_prefix}-rg-${var.r_env}-${random_integer.ri.result}"
  location = var.r_location
}

# hsd-transformation-rg-dev

# Create three apps all in linux and containers based.

module "app" {
  source          = "./modules/linuxapp"
  create_asp      = var.r_create_asp_linux
  existing_asp    = var.r_existing_aspl
  existing_asp_rg = var.r_existing_aspl_rg
  prefix          = var.r_prefix
  env             = var.r_env
  asp_name        = "${var.r_prefix}-asplinux-${var.r_env}-${random_integer.ri.result}"
  image_name      = "hsdtransformdev.azurecr.io/hsd-risk-assessments-app:latest"
  tier            = "Basic"
  size            = "B1"
  location        = "north europe"
  # webapplist              = ["riskassessmentsapp", "graphapi", "safetyfirstapi"]
  webapplist          = var.r_app_names
  resource_group_name = azurerm_resource_group.rg.name
  scm_ip_restriction  = ["31.121.101.144/28", "31.121.101.128/29", "202.89.106.0/23"]
  app_settings = {
    PORT = "8000"
  }

}

# hsdriskassessmentsappuat
# hsdgraphapiuat
# hsdsafetyfirstapiuat
