variable "hubNetworkId" {
	type 		= string
	nullable 	= false
}

variable "hubPeeringPrefix" {
	type 		= string
	nullable 	= false
	default 	= "spoke"
}

variable "spokeNetworkId" {
	type 		= string
	nullable    = false
}

variable "spokePeeringPrefix" {
	type 		= string
	nullable 	= false
	default 	= "hub"
}