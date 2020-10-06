// Deploy the MSO Template configuration
module "demo_template" {
  source  = "app.terraform.io/cisco-dcn-ecosystem/demo_template/mso"
  version = "0.0.2"

  mso_username = var.mso_username
  mso_password = var.mso_password
  mso_url = var.mso_url
  name_prefix = "TF-"
  schema_name = "terraform_hybrid_cloud"
  subnet_gw = "10.101.10.254/24"
  tenant = "WoS"
}