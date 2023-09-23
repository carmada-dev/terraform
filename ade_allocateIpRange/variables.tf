variable "resourceGroup" {
	type 		= string
	description = "Name of the environment resource group"
}

variable "cidrBlocks" {
	type 		= list(number)
	nullable 	= false
	description = "The list of CIDR block to allocate"
}

variable "verbose" {
	type		= bool
	nullable	= false
	default 	= false
	description = "Execute module in verbose mode"
}
