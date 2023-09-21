output "environmentName" {

  value = data.azurerm_resource_group.Environment.name
  description = "Get the environment name"

}

output "environmentLocation" {

  value = data.azurerm_resource_group.Environment.location
  description = "Get the environment location"

}

output "environmentSuffix" {

  value = arm2tf_unique_string.environment.result
  description = "Get the environment suffix"

}

output "privateLinkDnsZoneRG" {

  value = data.external.Settings_PrivateLinkDnsZoneRG
  description = "Get setting PrivateLinkDnsZoneRG"

}

output "projectNetworkId" {

  value = data.external.Settings_ProjectNetworkId
  description = "Get setting ProjectNetworkId"

}

output "projectGatewayIP" {

  value = data.external.Settings_ProjectGatewayIP
  description = "Get setting ProjectGatewayIP"

}