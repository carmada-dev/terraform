resource "arm2tf_guid" "HubNetworkGuid" {
  input = [ 
	"${var.hubNetworkId}"
  ]
}

resource "arm2tf_guid" "SpokeNetworkGuid" {
  input = [
    "${var.spokeNetworkId}"
  ]
}

resource "null_resource" "Peering" {

	triggers = {
		HubNetworkId = "${var.hubNetworkId}"
		HubPeeringName = "${var.hubPeeringPrefix}-${arm2tf_guid.SpokeNetworkGuid.result}"
	  	SpokeNetworkId = "${var.spokeNetworkId}"
		SpokePeeringName = "${var.spokePeeringPrefix}-${arm2tf_guid.HubNetworkGuid.result}" 
	}

	provisioner "local-exec" {
    	command = <<-EOC

az network vnet peering create \
	--name ${self.triggers.HubPeeringName} \
	--subscription ${element(split("/", "${self.triggers.HubNetworkId}"),2)} \
	--resource-group ${element(split("/", "${self.triggers.HubNetworkId}"),4)} \
	--vnet-name ${element(split("/", "${self.triggers.HubNetworkId}"),8)} \
	--remote-vnet ${self.triggers.SpokeNetworkId} \
	--allow-vnet-access \
	--allow-forwarded-traffic \
	--only-show-errors \
	--output none

az network vnet peering create \
	--name ${self.triggers.SpokePeeringName} \
	--subscription ${element(split("/", "${self.triggers.SpokeNetworkId}"),2)} \
	--resource-group ${element(split("/", "${self.triggers.SpokeNetworkId}"),4)} \
	--vnet-name ${element(split("/", "${self.triggers.SpokeNetworkId}"),8)} \
	--remote-vnet ${self.triggers.HubNetworkId} \
	--allow-vnet-access \
	--allow-forwarded-traffic \
	--only-show-errors \
	--output none

EOC
  	}
  
  	provisioner "local-exec" {
		when    = destroy
		command = <<-EOC

az network vnet peering delete \
	--name ${self.triggers.HubPeeringName} \
	--subscription ${element(split("/", "${self.triggers.HubNetworkId}"),2)} \
	--resource-group ${element(split("/", "${self.triggers.HubNetworkId}"),4)} \
	--vnet-name ${element(split("/", "${self.triggers.HubNetworkId}"),8)} \
	--only-show-errors \
	--output none

az network vnet peering delete \
	--name ${self.triggers.SpokePeeringName} \
	--subscription ${element(split("/", "${self.triggers.SpokeNetworkId}"),2)} \
	--resource-group ${element(split("/", "${self.triggers.SpokeNetworkId}"),4)} \
	--vnet-name ${element(split("/", "${self.triggers.SpokeNetworkId}"),8)} \
	--only-show-errors \
	--output none

EOC
	}

}
