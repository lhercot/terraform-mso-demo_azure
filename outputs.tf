output "subnet_name" {
  value = "subnet-10.101.210.128_25"
  description = "The ACI subnet object name"
}

output "azure_site_id" {
  value = data.mso_site.azure.id
  description = "The id of the Azure Site"
}

output "resource_group_name" {
  value = "CAPIC_${var.tenant}_${var.name_prefix}Hybrid_Cloud_VRF_westus"
  description = "The resource_group_name"
}

output "virtual_network_name" {
  value = "${var.name_prefix}Hybrid_Cloud_VRF"
  description = "The virtual network name"
}