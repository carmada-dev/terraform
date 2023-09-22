variable "resourceGroup" {
	type 		= string
	nullable	= true
	description = "Name of the environment resource group"
}

variable "cidrBlocks" {
	type 		= list(number)
	nullable 	= false
}

variable "verbose" {
	type		= bool
	nullable	= false
	default 	= false
}
