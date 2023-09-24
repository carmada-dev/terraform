output "Environment" {
  value = {
    Name = data.azurerm_resource_group.Environment.name
    Type = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationLabel"]
    Location = data.azurerm_resource_group.Environment.location
    Suffix = jsondecode(azurerm_resource_group_template_deployment.Environment.output_content).uniqueString.value
  }
}

output "Configuration" {
  value = {
    Store = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationStoreId"]
    Vault = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationVaultId"]
  }
}

output "Settings" {

  value = tomap({ for item in data.azurerm_app_configuration_keys.Environment.items : item.key => item.value if item.type == "kv" })
}
