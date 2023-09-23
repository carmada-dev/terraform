variable "resourceGroup" {
	type 		= string
	description = "Name of the environment resource group"
}

variable "networkName" {
  type 			= string
  description 	= "Name of the network resource to link"
}

variable "dnsZoneName" {
  type 			= string
  description 	= "Name of the DNS zone to link"
}