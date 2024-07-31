resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# To check
resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  # for_each = var.virtual_networks_to_link

  # name                  = "link_to_${lower(basename(each.key))}"
  name                  = "link_to_${lower(basename(var.virtual_networks_to_link_id))}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  # virtual_network_id    = "/subscriptions/${each.value.subscription_id}/resourceGroups/${each.value.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${each.key}"
  virtual_network_id    = var.virtual_networks_to_link_id

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
