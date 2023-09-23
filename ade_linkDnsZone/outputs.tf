output "DnsZoneId" {
  value = data.external.DNSZone.result.DNSZONEID
}

output "DnsZoneName" {
  value = data.external.DNSZone.result.DNSZONENAME
}