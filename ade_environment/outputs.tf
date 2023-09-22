output "Environment" {
  value = {
    Name = data.azurerm_resource_group.Environment.name
    Type = data.azurerm_resource_group.Environment.tags["hidden-ConfigurationLabel"]
    Location = data.azurerm_resource_group.Environment.location
    Suffix = azurerm_template_deployment.Environment.outputs["uniqueString"]
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
