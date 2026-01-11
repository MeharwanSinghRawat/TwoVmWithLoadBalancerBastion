resource_group = {
  rg1 = {
    rg_name    = "mehar_app-rg"
    location   = "east us"
    managed_by = "azurerm_user_assigned_identity.test"
    # tags = {
    #   environment = "dev"
    #   project     = "terraform-setup"
    # }
  }

}

virtual_network = {
  vnet1 = {
    vnet_name     = "meharVnet"
    rg_name       = "mehar_app-rg"
    location      = "east us"
    address_space = ["10.0.0.0/16"]
    # dns_servers             = ["8.8.8.8", "8.8.4.4"]
    # flow_timeout_in_minutes = 10
    # tags = {
    #   environment = "dev"
    #   project     = "terraform-setup"
    #   owner       = "mehar"
    # }
  }
}

subnet = {
  subnet1 = {
    subnet_name      = "meharsubnet1"
    vnet_name        = "meharVnet"
    rg_name          = "mehar_app-rg"
    address_prefixes = ["10.0.0.0/24"]
    # service_endpoints = ["Microsoft.Storage"]
    # delegation = [
    #   {
    #     name = "delegation1"
    #     service_delegation = {
    #       name    = "Microsoft.Web/serverFarms"
    #       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    #     }
    #   }
    # ]
  }

  subnet2 = {
    subnet_name                           = "meharsubnet2"
    vnet_name                             = "meharVnet"
    rg_name                               = "mehar_app-rg"
    address_prefixes                      = ["10.0.1.0/24"]
    private_endpoint_network_policies     = "Disabled"
    private_link_service_network_policies = "Enabled"
    # delegation = [
    #   {
    #     name = "delegation1"
    #     service_delegation = {
    #       name    = "Microsoft.Web/serverFarms"
    #       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    #     }
    #   }
    # ]
  }
}

public_ip = {
  lbpip = {
    pip_name          = "mehar-lb-pip"
    rg_name           = "mehar_app-rg"
    location          = "east us"
    allocation_method = "Static"
    sku               = "Standard"
    domain_name_label = "mehar-lb"
    # idle_timeout_in_minutes = 10
    # zones                   = ["1", "2", "3"]
    # tags = {
    #   environment = "dev"
    #   project     = "loadbalancer"
    # }
  }

  bastion_pip = {
    pip_name          = "mehar-bastion-pip"
    rg_name           = "mehar_app-rg"
    location          = "east us"
    allocation_method = "Static"
    sku               = "Standard"
    # domain_name_label = "mehar-bastion"
  }


}


network_nic = {
  nic1 = {
    nic_name                      = "meharnic1"
    location                      = "east us"
    rg_name                       = "mehar_app-rg"
    ip_config_name                = "internal"
    private_ip_meth               = "Dynamic"
    subnet_name                   = "meharsubnet1"
    vnet_name                     = "meharVnet"
    enable_accelerated_networking = true
    tags = {
      environment = "dev"
      owner       = "mehar"
    }
  }

  nic2 = {
    nic_name             = "meharnic2"
    location             = "east us"
    rg_name              = "mehar_app-rg"
    ip_config_name       = "internal"
    private_ip_meth      = "Dynamic"
    subnet_name          = "meharsubnet2"
    vnet_name            = "meharVnet"
    enable_ip_forwarding = true
  }
}


virtual_machine = {
  vm1 = {
    vm_name        = "vm1"
    rg_name        = "mehar_app-rg"
    location       = "east us"
    vm_size        =  "Standard_DC1ds_v3"
    admin_username = "Useradmin"
    admin_password = "Useradmin@1234"
    nic_name       = "meharnic1"
  }

  vm2 = {
    vm_name        = "vm2"
    rg_name        = "mehar_app-rg"
    location       = "east us"
    vm_size        =  "Standard_DC1ds_v3"
    admin_username = "Useradmin"
    admin_password = "Useradmin@1234"
    nic_name       = "meharnic2"
  }
}


loadbalancer = {
  lb1 = {
    lb_name           = "TestLoadBalancer"
    location          = "east us"
    rg_name           = "mehar_app-rg"
    frontend_ip_name  = "frontendlbip"
    backend_pool_name = "BackEndAddressPool"
    lb_rule_name      = "newrule1"
    protocol          = "Tcp"
    frontend_port     = 80
    backend_port      = 80
    lb_prob_name      = "lbprob1"
    lb_prob_port      = 80
    pip_name          = "mehar-lb-pip"
  }
}

network_nsg = {
  nsg1 = {
    nsg_name = "web-nsg"
    location = "eastus"
    rg_name  = "mehar_app-rg"

    rules = [
      {
        rule_name                  = "allow-http"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  nsg2 = {
    nsg_name = "db-nsg"
    location = "eastus"
    rg_name  = "mehar_app-rg"

    rules = [
      {
        rule_name                  = "allow-sql"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "1433"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}


azure_bastion = {
  bastion1 = {
    bastion_name       = "mehar-bastion"
    location           = "eastus"
    rg_name            = "mehar_app-rg"
    vnet_name          = "meharVnet"
    bastion_subnetname = "AzureBastionSubnet"
    address_prefixes   = ["10.0.3.0/27"]
    pip_name           = "mehar-bastion-pip"
  }
}

# vmss = {
#   web = {
#     name           = "web-vmss"
#     rg_name        = "mehar_app-rg"
#     location       = "eastus"
#     sku            = "Standard_D2s_v3"
#     instance_count = 2
#     subnet_id      = "/subscriptions/.../subnets/meharsubnet1"
#     admin_username = "Useradmin"
#     admin_password = "Useradmin@1234"
#     lb_backend_pool_id = "/subscriptions/.../backendAddressPools/BackEndAddressPool"
#   }
# }


# sql_data_server = {

#   sqldata = {

#     sql_server_name = "msrsinghsqlserver"
#     rg_name         = "mehar_app-rg"
#     location        = "east us"
#     version         = "12.0"
#     userlogin       = "Useradmin"
#     userpassword    = "Useradmin@1234"
#     minimum_version = "1.2"
#     database_name   = "mehardb-db"

#   }

# }



# keyvaults = {
#   kv-eastus = {
#     keyvault_name              = "mehar-kv-eastus"
#     location                   = "East US"
#     rg_name                    = "mehar_app-rg"
#     sku_name                   = "premium"
#     soft_delete_retention_days = 30
#     key_permissions            = ["Create", "Get", "List"]
#     secret_permissions         = ["Set", "Get", "Delete", "Recover"]
#   }


# }


# aks_clusters = {
#   dev = {
#     cluster_name       = "aks-dev"
#     location           = "eastus"
#     rg_name            = "mehar_app-rg"
#     dns_prefix         = "devaks"
#     kubernetes_version = "1.30.0"
#     identity_type      = "SystemAssigned" # 👈 added

#     default_node_pool = {
#       name       = "systempool"
#       node_count = 1
#       vm_size    = "standard_a2_v2"
#     }

#     network_profile = {
#       network_plugin    = "azure"
#       network_policy    = "calico"
#       load_balancer_sku = "standard"
#     }

#     tags = {
#       env = "dev"
#     }
#   }
# }


