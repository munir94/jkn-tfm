resource "azurerm_route_table" "rt" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dynamic "route" {
    for_each = var.routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = lookup(route.value, "next_hop_in_ip_address", null)
    }
  }
  disable_bgp_route_propagation = var.disable_bgp_route_propagation
  tags                          = var.tags
}
#https://github.com/aztfm/terraform-azurerm-route-table/blob/main/examples/route-table-with-routes/main.tf
resource "azurerm_subnet_route_table_association" "rtaasociate" {
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.rt.id
}