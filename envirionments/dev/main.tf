module "resource_group" {
  source         = "../../Child_Module/azurerm_resource_group"
  resource_group = var.resource_group

}
module "virtual_network" {
  source          = "../../Child_Module/azurerm_virtual_network"
  virtual_network = var.virtual_network
  depends_on      = [module.resource_group]
}

module "subnet" {
  source     = "../../Child_Module/azurerm_subnet"
  subnet     = var.subnet
  depends_on = [module.virtual_network]
}

module "public_Ip" {
  source     = "../../Child_Module/azurerm_public_ip"
  public_ip  = var.public_ip
  depends_on = [module.resource_group, module.subnet]
}

module "network_interface" {
  source      = "../../Child_Module/azurerm_NetworkInterface"
  network_nic = var.network_nic
  depends_on  = [module.subnet, module.resource_group]

}

module "network_security_group" {
  source      = "../../Child_Module/azurerm_Network_Security_Group"
  network_nsg = var.network_nsg
  network_nic = var.network_nic
  depends_on  = [module.network_interface, module.resource_group]

}


module "azure_bation" {
  source        = "../../Child_Module/azurerm_bastion"
  azure_bastion = var.azure_bastion
  depends_on    = [module.public_Ip]
}

module "load_balancer" {
  source       = "../../Child_Module/azurerm_load_balancer"
  loadbalancer = var.loadbalancer
  network_nic  = var.network_nic
  depends_on   = [module.public_Ip, module.network_interface,]

}

module "virtual_machine" {
  source          = "../../Child_Module/azurem_virtual_machines"
  virtual_machine = var.virtual_machine
    depends_on      = [module.network_interface, module.subnet]
  }

# module "virtual_vmss" {
#   source          = "../../Child_Module/azurerm_vmss"
#   vmss            = var.vmss
#   depends_on      = [module.network_interface, module.subnet]

# }

# module "azurerm_mssql_server" {
#   source          = "../../Child_Module/azurerm_sql_dataserver"
#   sql_data_server = var.sql_data_server
#   depends_on      = [module.resource_group]

# }

# module "azurerm_key_vault" {
#   source     = "../../Child_Module/azurerm_keyvault"
#   keyvaults  = var.keyvaults
#   depends_on = [var.resource_group]

# }

# module "azurerm_kubernetes_cluster" {

#   source       = "../../Child_Module/azurerm_kubernetes_cluster"
#   aks_clusters = var.aks_clusters

# }

