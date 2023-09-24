data "azurerm_resource_group" "Environment" {
  	name 				= var.resourceGroup
}

resource "azurerm_resource_group_template_deployment" "Environment" {
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

data "azurerm_app_configuration_keys" "Environment" {
  configuration_store_id = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationStoreId"]
}
