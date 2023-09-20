variable "configurationStoreId" {
	type 		= string
	nullable 	= false
}

variable "configurationLabel" {
	type 		= string
	nullable 	= false
}

variable "cidrBlocks" {
	type 		= list(number)
	nullable 	= false
}

