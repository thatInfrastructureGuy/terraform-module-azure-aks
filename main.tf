
//-----------------AKS Networking--------------------------
resource "azurerm_virtual_network" "k8s_advanced_network" {
  name                       = "${var.resource_group_name}vnet"
  location                   = "${var.resource_group_location}"
  resource_group_name        = "${var.resource_group_name}"
  address_space              = ["10.0.0.0/8"]
  tags {
      Environment            = "${var.tag_environment}"
      Region                 = "${var.tag_region}"
      Product                = "${var.tag_product}"
  }
}

resource "azurerm_subnet" "k8s_subnet" {
  name                       = "${var.resource_group_name}k8sSubnet"
  resource_group_name        = "${var.resource_group_name}"
  address_prefix             = "10.240.0.0/12"
  virtual_network_name       = "${azurerm_virtual_network.k8s_advanced_network.name}"
  service_endpoints          = ["Microsoft.Storage"]
}

//-----------------AKS------------------------------------
resource "azurerm_kubernetes_cluster" "k8s" {
  name                       = "${var.resource_group_name}"
  location                   = "${var.resource_group_location}"
  resource_group_name        = "${var.resource_group_name}"
  dns_prefix                 = "${var.resource_group_name}"
  kubernetes_version         = "${var.kubernetes_version}"
  
  agent_pool_profile {
    name                     = "${var.worker_pool_name}"
    count                    = "${var.worker_vm_count}"
    vm_size                  = "${var.worker_vm_size}"
    os_type                  = "${var.worker_os_type}"
    os_disk_size_gb          = "${var.worker_os_disk_size}"

    # Required for advanced networking
    vnet_subnet_id           = "${azurerm_subnet.k8s_subnet.id}"
  }

  service_principal {
    client_id                = "${var.azure_client_id}"
    client_secret            = "${var.azure_client_secret}"
  }

  tags {
      Environment            = "${var.tag_environment}"
      Region                 = "${var.tag_region}"
      Product                = "${var.tag_product}"
  }
 
   network_profile {
    network_plugin           = "${var.network_profile_plugin}"
    network_policy           = "${var.network_profile_policy}"
  }

  role_based_access_control {
    enabled                  = true
    
    azure_active_directory {
      client_app_id          = "${var.ad_client_app_id}"
      server_app_id          = "${var.ad_server_app_id}"
      server_app_secret      = "${var.ad_server_app_secret}"
    }
  }

}

output "kube_config" {
  value                      = "\n${azurerm_kubernetes_cluster.k8s.kube_config_raw}\n"
}
output "kube_admin_config" {
  value                      = "\n${azurerm_kubernetes_cluster.k8s.kube_admin_config_raw}\n"
}
output "k8s_advanced_network_name" {
  value                      = "${azurerm_virtual_network.k8s_advanced_network.name}"
}
output "k8s_subnet_id" {
  value                      = "${azurerm_subnet.k8s_subnet.id}"
}
