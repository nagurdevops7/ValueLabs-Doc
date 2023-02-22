# To create a new "App Service Plan"
resource "azurerm_app_service_plan" "new" {

  count               = var.create_asp ? 1 : 0
  name                = var.asp_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "linux"
  reserved            = true
  sku {
    tier = var.tier
    size = var.size
  }
}

# Fetch details for existing "App Service Plan"
data "azurerm_app_service_plan" "existing" {
  count = var.create_asp ? 0 : 1

  name                = var.existing_asp
  resource_group_name = var.existing_asp_rg
}

locals {
  appid                 = element(concat(azurerm_app_service_plan.new.*.id, data.azurerm_app_service_plan.existing.*.id), 0)
  location              = element(concat(azurerm_app_service_plan.new.*.location, data.azurerm_app_service_plan.existing.*.location), 0)
  l_resource_group_name = var.create_asp == true ? var.resource_group_name : var.existing_asp_rg

}
resource "azurerm_app_service" "this" {
  for_each = toset(var.webapplist)

  name                = "${var.prefix}${each.value}${var.env}"
  location            = local.location
  resource_group_name = local.l_resource_group_name
  app_service_plan_id = local.appid


  site_config {
    always_on        = true
    ftps_state       = "FtpsOnly"
    http2_enabled    = true
    linux_fx_version = "DOCKER | ${var.image_name}"
    dynamic "scm_ip_restriction" {
      for_each = toset(var.scm_ip_restriction)
      content {
        ip_address = scm_ip_restriction.key
      }
    }
  }

  # app_settings = var.app_settings
  #   app_settings = {

  #      "APPINSIGHTS_INSTRUMENTATIONKEY"      = azurerm_application_insights.appinsights.instrumentation_key
  #     "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.appinsights.connection_string
  #   }


  # }

  # # Create application insights
  # resource "azurerm_application_insights" "appinsights" {
  #    for_each           = toset(var.webapplist)

  #   name                = "${var.prefix}${each.value}${var.env}"
  #   location            = local.location
  #   resource_group_name = local.l_resource_group_name
  #   application_type    = "web"


}
