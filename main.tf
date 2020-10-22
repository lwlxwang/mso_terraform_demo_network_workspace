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
  version = "0.0.4"

  name_prefix = var.name_prefix
  schema_name = var.schema_name
  subnet_gw = "10.101.10.254/24"
  tenant = var.tenant
}

// Add the On-Premises site
module "demo_onprem" {
  source  = "app.terraform.io/cisco-dcn-ecosystem/demo_onprem/mso"
  version = "0.0.7"

  name_prefix = var.name_prefix
  site_name = "On-premises"
  schema_name = var.schema_name
  tenant = var.tenant
}

// Add the Azure site
module "demo_azure" {
  source  = "app.terraform.io/cisco-dcn-ecosystem/demo_azure/mso"
  version = "0.0.9"

  name_prefix = var.name_prefix
  site_name = "Azure-West"
  schema_name = var.schema_name
  tenant = var.tenant
}