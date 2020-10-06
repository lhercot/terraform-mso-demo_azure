variable "name_prefix" {
  type = string
  default = "TF-"
  description = "A prefix that will be added to all the object names"
}

variable "site_name" {
  type = string
  default = "Azure-West"
  description = "Name of the AWS site"
}

variable "schema_name" {
  type = string
  default = "terraform_hybrid_cloud"
  description = "The name of the MSO schema to be used"
}

variable "mso_username" {}
variable "mso_password" {}
variable "mso_url" {}