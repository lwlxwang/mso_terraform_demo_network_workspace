terraform {
  required_providers {
    mso = {
      source = "CiscoDevNet/mso"
    }
  }
}

provider "mso" {
  # Configuration options
  username  = var.mso_username
  password  = var.mso_password
  url       = var.mso_url
  insecure  = true
}

// Deploy the MSO Template configuration
module "demo_template" {
  source  = "app.terraform.io/cisco-dcn-ecosystem/demo_template/mso"
  version = "0.0.3"

  mso_username = var.mso_username
  mso_password = var.mso_password
  mso_url = var.mso_url
  name_prefix = var.name_prefix
  schema_name = var.schema_name
  subnet_gw = "10.101.10.254/24"
  tenant = var.tenant
}

# Add the On-Premises site
module "demo_onprem" {
  source  = "app.terraform.io/cisco-dcn-ecosystem/demo_onprem/mso"
  version = "0.0.6"

  mso_username = var.mso_username
  mso_password = var.mso_password
  mso_url = var.mso_url
  name_prefix = var.name_prefix
  site_name = "On-premises"
  schema_name = var.schema_name
  tenant = var.tenant
}

# Add the Azure site
module "demo_azure" {
  source  = "app.terraform.io/cisco-dcn-ecosystem/demo_azure/mso"
  version = "0.0.4"

  mso_username = var.mso_username
  mso_password = var.mso_password
  mso_url = var.mso_url
  name_prefix = var.name_prefix
  site_name = "Azure-West"
  schema_name = var.schema_name
  tenant = var.tenant
}

data "mso_schema" "hybrid_cloud" {
  name = var.schema_name
  depends_on = [ module.demo_template ]
}

resource "mso_schema_template_external_epg" "extepg_cloud_internet" {
  schema_id         = data.mso_schema.hybrid_cloud.id
  template_name     = "Template1"
  external_epg_name = "Cloud-Internet"
  display_name      = "Cloud-Internet"
  external_epg_type = "cloud"
  vrf_name          = "${var.name_prefix}Hybrid_Cloud_VRF"
  vrf_template_name = "Template1"
  anp_name          = "${var.name_prefix}App"
  selector_name     = "Internet"
  selector_ip       = "0.0.0.0/0"
  site_id           = [ 
    module.demo_azure.azure_site_id,
    module.demo_onprem.onprem_site_id
  ]
}

resource "mso_schema_template_external_epg_contract" "extepg_cloud_internet_c1" {
  schema_id         = data.mso_schema.hybrid_cloud.id
  template_name     = mso_schema_template_external_epg.extepg_cloud_internet.template_name
  contract_name     = "${var.name_prefix}Internet-to-Web"
  external_epg_name = mso_schema_template_external_epg.extepg_cloud_internet.external_epg_name
  relationship_type = "consumer"
}

resource "mso_schema_template_external_epg_contract" "extepg_cloud_internet_c2" {
  schema_id         = data.mso_schema.hybrid_cloud.id
  template_name     = mso_schema_template_external_epg.extepg_cloud_internet.template_name
  contract_name     = "${var.name_prefix}VMs-to-Internet"
  external_epg_name = mso_schema_template_external_epg.extepg_cloud_internet.external_epg_name
  relationship_type = "provider"
}