
data "azurerm_app_configuration_key" "Settings_IPAlloc_URL" {
  configuration_store_id = var.configurationStoreId
  key                    = "IPAlloc-URL"
}

resource "null_resource" "IPAlloc" {

	triggers = {
		AllocationUrl = "${trimsuffix(trimspace(data.azurerm_app_configuration_key.Settings_IPAlloc_URL.value), "/")}/${uuid()}"
		AllocationQuery = "env=${trimspace(var.configurationLabel)}&cidr=${join("&cidr=", var.cidrBlocks)}"
	}

	provisioner "local-exec" {
    	command = <<-EOC
TOKEN=$(az account get-access-token --query accessToken --output tsv)
curl -sS -X POST "${self.triggers.AllocationUrl}?${self.triggers.AllocationQuery}" -H "Accept: application/json" -H "Authorization: Bearer $TOKEN"
EOC
  	}
  
  	provisioner "local-exec" {
		when    = destroy
		command = <<-EOC
TOKEN=$(az account get-access-token --query accessToken --output tsv)
curl -sS -X DELETE "${self.triggers.AllocationUrl}" -H "Accept: application/json" -H "Authorization: Bearer $TOKEN"
EOC
	}

}

data "external" "IPAlloction" {
	program = [ "bash", "${path.module}/scripts/IPAlloction.sh"]
	query = {
	  URL = "${resource.null_resource.IPAlloc.triggers.AllocationUrl}"
	}
}