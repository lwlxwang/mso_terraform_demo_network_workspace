variable "mso_username" {}
variable "mso_password" {}
variable "mso_url" {}

variable "name_prefix" {
  type = string
  default = "TF-"
  description = "A prefix that will be added to all the object names"
}

variable "schema_name" {
  type = string
  default = "terraform_hybrid_cloud"
  description = "The name of the MSO schema to be created"
}

variable "tenant" {
  type = string
  default = "WoS"
  description = "The MSO tenant to use for this configuration"
}