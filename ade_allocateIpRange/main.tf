module "ade_context" {
	source 				= "git::https://git@github.com/carmada-dev/terraform.git//ade_context?ref=main"
	resourceGroup		= var.resourceGroup
}

resource "null_resource" "IPAlloc" {

	triggers = {
		AllocationUrl 	= "${trimsuffix(trimspace(module.ade_context.Settings["IPAlloc-URL"]), "/")}/allocation/${uuid()}"
		AllocationQuery = "env=${trimspace(module.ade_context.Environment.Type)}&cidr=${join("&cidr=", var.cidrBlocks)}"
		VerboseSwitch 	= "${var.verbose ? "-v" : "-sS"}"
	}

	provisioner "local-exec" {
    	command 		= <<-COMMAND

TOKEN=$(az account get-access-token --query accessToken --output tsv)
curl ${try(self.triggers.VerboseSwitch, "-sS")} -X POST "${self.triggers.AllocationUrl}?${self.triggers.AllocationQuery}" -H "Accept: application/json" -H "Authorization: Bearer $TOKEN"

COMMAND
  	}
  
  	provisioner "local-exec" {
		when    	= destroy
		on_failure 	= continue
		command 	= <<-COMMAND

TOKEN=$(az account get-access-token --query accessToken --output tsv)
curl ${try(self.triggers.VerboseSwitch, "-sS")} -X DELETE "${self.triggers.AllocationUrl}" -H "Accept: application/json" -H "Authorization: Bearer $TOKEN"

COMMAND
	}

}

data "external" "IPAlloction" {
	program 			= [ "bash", "${path.module}/scripts/IPAlloction.sh"]
	query = {
	  URL 				= "${resource.null_resource.IPAlloc.triggers.AllocationUrl}"
	  VERBOSE 			= "${try(resource.null_resource.IPAlloc.triggers.VerboseSwitch, "-sS")}"
	}

	depends_on 			= [ null_resource.IPAlloc ]
}