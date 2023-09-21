output "EnvironmentName" {

  value = data.azurerm_resource_group.Environment.name
  description = "Get the environment name"

}

output "EnvironmentLocation" {

  value = data.azurerm_resource_group.Environment.location
  description = "Get the environment location"

}

output "EnvironmentSuffix" {

  value = arm2tf_unique_string.Environment.result
  description = "Get the environment suffix"

}

output "EnvironmentType" {
  
  value = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationLabel"]
  description = "Get the environment type"
}

output "PrivateLinkDnsZoneRG" {

  value = azurerm_app_configuration_key.Settings_PrivateLinkDnsZoneRG.value
  description = "Get setting PrivateLinkDnsZoneRG"

}

output "ProjectNetworkId" {

  value = azurerm_app_configuration_key.Settings_ProjectNetworkId.value
  description = "Get setting ProjectNetworkId"

}

output "ProjectGatewayIP" {

  value = azurerm_app_configuration_key.Settings_ProjectGatewayIP.value
  description = "Get setting ProjectGatewayIP"

}

output "IPAlloc_URL" {

  value = azurerm_app_configuration_key.Settings_IPAlloc_URL.value
  description = "Get setting IPAlloc_URL"

}