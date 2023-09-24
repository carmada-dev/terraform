module "ade_context" {
	source 				= "git::https://git@github.com/carmada-dev/terraform.git//ade_context?ref=main"
	resourceGroup		= var.resourceGroup
}

data "azurerm_virtual_network" "Environment" {
	name 				= var.networkName
	resource_group_name = var.resourceGroup
}

resource "azurerm_resource_group_template_deployment" "Peering" {
  name                	= "peering-${uuid()}"
  resource_group_name 	= var.resourceGroup
  deployment_mode     	= "Incremental"
  template_content      = <<-TEMPLATE
        {
          "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
          "contentVersion": "1.0.0.0",
          "resources": [],
          "outputs": {
              "peeringProject2Environment": {
                  "type": "string",
                  "value": "[concat('environment-', guid('${data.azurerm_virtual_network.Environment.id}'))]"
              },
              "peeringEnvironment2Project": {
                  "type": "string",
                  "value": "[concat('project-', guid('${module.ade_context.Settings["ProjectNetworkId"]}'))]"
              }
          }
        }
TEMPLATE
}

resource "null_resource" "Peering" {

	triggers = {
		HubNetworkId = module.ade_context.Settings["ProjectNetworkId"]
		HubPeeringName = jsondecode(azurerm_resource_group_template_deployment.Peering.output_content).peeringProject2Environment.value
	  	SpokeNetworkId = data.azurerm_virtual_network.Environment.id
		SpokePeeringName = jsondecode(azurerm_resource_group_template_deployment.Peering.output_content).peeringEnvironment2Project.value
	}

	provisioner "local-exec" {
    	command = <<-EOC

az network vnet peering create \
	--name ${self.triggers.HubPeeringName} \
	--subscription ${element(split("/", "${self.triggers.HubNetworkId}"),2)} \
	--resource-group ${element(split("/", "${self.triggers.HubNetworkId}"),4)} \
	--vnet-name ${element(split("/", "${self.triggers.HubNetworkId}"),8)} \
	--remote-vnet ${self.triggers.SpokeNetworkId} \
	--allow-vnet-access \
	--allow-forwarded-traffic \
	--only-show-errors \
	--output none

az network vnet peering create \
	--name ${self.triggers.SpokePeeringName} \
	--subscription ${element(split("/", "${self.triggers.SpokeNetworkId}"),2)} \
	--resource-group ${element(split("/", "${self.triggers.SpokeNetworkId}"),4)} \
	--vnet-name ${element(split("/", "${self.triggers.SpokeNetworkId}"),8)} \
	--remote-vnet ${self.triggers.HubNetworkId} \
	--allow-vnet-access \
	--allow-forwarded-traffic \
	--only-show-errors \
	--output none

EOC
  	}
  
  	provisioner "local-exec" {
		when    = destroy
		command = <<-EOC

az network vnet peering delete \
	--name ${self.triggers.HubPeeringName} \
	--subscription ${element(split("/", "${self.triggers.HubNetworkId}"),2)} \
	--resource-group ${element(split("/", "${self.triggers.HubNetworkId}"),4)} \
	--vnet-name ${element(split("/", "${self.triggers.HubNetworkId}"),8)} \
	--only-show-errors \
	--output none

az network vnet peering delete \
	--name ${self.triggers.SpokePeeringName} \
	--subscription ${element(split("/", "${self.triggers.SpokeNetworkId}"),2)} \
	--resource-group ${element(split("/", "${self.triggers.SpokeNetworkId}"),4)} \
	--vnet-name ${element(split("/", "${self.triggers.SpokeNetworkId}"),8)} \
	--only-show-errors \
	--output none

EOC
	}

}
