output "db_gateway" {
  value = module.demo_template.db_gateway
  description = "The gateway IP address for On-premises network"
}

output "vmware_vds" {
  value = module.demo_onprem.vmware_vds
  description = "The name of the VMware VDS used"
}

output "vmware_portgroup" {
  value = module.demo_onprem.vmware_portgroup
  description = "The name of the VMware portgroup used"
}

output "azure_subnet_name" {
  value = module.demo_azure.subnet_name
  description = "The ACI Azure subnet object name"
}

output "resource_group_name" {
  value = module.demo_azure.resource_group_name
  description = "The Azure resource_group_name"
}

output "virtual_network_name" {
  value = module.demo_azure.virtual_network_name
  description = "The Azure virtual network name"
}

output "aws_subnet_dn" {
  value = module.demo_aws.subnet_dn
  description = "The ACI AWS subnet object DN"
}

output "aws_region" {
  value = module.demo_aws.region
  description = "The AWS region"
}