output "EnvironmentName" {

  value = data.azurerm_resource_group.Environment.name
  description = "Get the environment name"

}

output "EnvironmentLocation" {

  value = data.azurerm_resource_group.Environment.location
  description = "Get the environment location"

}

output "EnvironmentSuffix" {

  value = arm2tf_unique_string.environment.result
  description = "Get the environment suffix"

}

output "EnvironmentType" {
  
  value = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationStoreId"]
  description = "Get the environment type"
}

output "PrivateLinkDnsZoneRG" {

  value = data.external.Settings_PrivateLinkDnsZoneRG
  description = "Get setting PrivateLinkDnsZoneRG"

}

output "ProjectNetworkId" {

  value = data.external.Settings_ProjectNetworkId
  description = "Get setting ProjectNetworkId"

}

output "ProjectGatewayIP" {

  value = data.external.Settings_ProjectGatewayIP
  description = "Get setting ProjectGatewayIP"

}

output "IPAlloc_URL" {

  value = data.external.Settings_IPAlloc_URL
  description = "Get setting IPAlloc_URL"

}