variable "admin_userpass_password" {
  type      = string
  sensitive = true
}

variable "initial_aws_access_key_id" {
  type = string
}

variable "initial_aws_secret_access_key" {
  type      = string
  sensitive = true
}
