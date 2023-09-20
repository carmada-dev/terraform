output "ip_ranges" {
  value = split(",", data.external.IPAlloction.result.IPRANGES)
}