data "external" "Environment" {
	program = [ "bash", "${path.module}/scripts/Environment.sh"]
}

data "azurerm_resource_group" "Environment" {
  name = "${data.external.Environment.ENVIRONMENT_RESOURCE_GROUP_NAME}"
}

resource "arm2tf_unique_string" "Environment" {
  input = [ data.azurerm_resource_group.Environment.id ]
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

data "azurerm_app_configuration_key" "Settings_IPAlloc_URL" {
  configuration_store_id = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationStoreId"]
  key                    = "IPAlloc-URL"
}

