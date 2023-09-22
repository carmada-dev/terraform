data "azurerm_resource_group" "Environment" {
  	name 				= var.resourceGroup
}

resource "azurerm_template_deployment" "Environment" {
  name                	= "uniqueString-${uuid()}"
  resource_group_name 	= data.azurerm_resource_group.Environment.name
  deployment_mode     	= "Incremental"
  template_body       	= <<-DEPLOY
        {
          "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
          "contentVersion": "1.0.0.0",
          "resources": [],
          "outputs": {
              "uniqueString": {
                  "type": "string",
                  "value": "[uniqueString(resourceGroup().id)]"
              }
          }
        }
DEPLOY
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

