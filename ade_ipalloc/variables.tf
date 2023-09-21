variable "cidrBlocks" {
	type 		= list(number)
	nullable 	= false
}

variable "verbose" {
	type		= bool
	nullable	= false
	default 	= false
}
