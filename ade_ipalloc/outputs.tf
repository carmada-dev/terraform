output "ip_ranges" {
  value = split(",", data.external.IPAlloction.value.IPRANGES)
}