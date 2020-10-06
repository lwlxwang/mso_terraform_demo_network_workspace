output "vmware_vds" {
  value = module.demo_onprem.vmware_vds
  description = "The name of the VMware VDS used"
}

output "vmware_portgroup" {
  value = module.demo_onprem.vmware_portgroup
  description = "The name of the VMware portgroup used"
}

output "db_gateway" {
  value = module.demo_template.db_gateway
  description = "The gateway IP address for On-premises network"
}

output "azure_subnet_dn" {
  value = module.demo_azure.subnet_dn
  description = "The ACI Azure subnet object DN"
}