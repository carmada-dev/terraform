data "azurerm_resource_group" "Environment" {
  name = "${var.resource_group_name}"
}

data "azurerm_app_configuration_key" "Settings_PrivateLinkDnsZoneRG" {
  configuration_store_id = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationStoreId"]
  key                    = "PrivateLinkDnsZoneRG"
}

data "azurerm_app_configuration_key" "Settings_ProjectNetworkId" {
  configuration_store_id = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationStoreId"]
  key                    = "ProjectNetworkId"
}

data "azurerm_app_configuration_key" "Settings_ProjectGatewayIP" {
  configuration_store_id = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationStoreId"]
  key                    = "ProjectGatewayIP"
}
