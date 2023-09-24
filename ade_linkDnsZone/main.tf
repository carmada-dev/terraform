module "ade_context" {
	source 				= "git::https://git@github.com/carmada-dev/terraform.git//ade_context?ref=main"
	resourceGroup		= var.resourceGroup
}

data "azurerm_virtual_network" "Environment" {
	name 				= var.networkName
	resource_group_name	= var.resourceGroup
}

data "external" "DNSZone" {
	program 					= [ "bash", "${path.module}/scripts/LinkDnsZone.sh"]
	query = {
	  RESOURCEGROUPID 			= module.ade_context.Settings["PrivateLinkDnsZoneRG"]
	  PROJECTNETWORKID 			= module.ade_context.Settings["ProjectNetworkId"]
	  ENVIRONMENTNETWORKID 		= data.azurerm_virtual_network.Environment.id
	  DNSZONENAME 				= var.dnsZoneName
	}
}