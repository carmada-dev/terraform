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