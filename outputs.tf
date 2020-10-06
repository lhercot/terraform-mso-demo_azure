output "subnet_dn" {
  value = "uni/tn-${var.tenant}/ctxprofile-${var.name_prefix}Hybrid_Cloud_VRF-westus/cidr-[10.101.210.0/24]/subnet-[10.101.210.128/25]"
  description = "The ACI subnet object DN"
}