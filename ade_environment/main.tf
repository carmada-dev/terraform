data "azurerm_resource_group" "Environment" {
  	name = var.resourceGroup
}

resource "arm2tf_unique_string" "Environment" {
  	input = [ "${data.azurerm_resource_group.Environment.id}" ]
}

data "azurerm_app_configuration_key" "PrivateLinkDnsZoneRG" {
  	configuration_store_id = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationStoreId"]
  	key                    = "PrivateLinkDnsZoneRG"
}

data "azurerm_app_configuration_key" "ProjectNetworkId" {
	configuration_store_id = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationStoreId"]
	key                    = "ProjectNetworkId"
}

data "azurerm_app_configuration_key" "ProjectGatewayIP" {
	configuration_store_id = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationStoreId"]
	key                    = "ProjectGatewayIP"
}

data "azurerm_app_configuration_key" "IPAlloc_URL" {
	configuration_store_id = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationStoreId"]
	key                    = "IPAlloc-URL"
}

