# resource "vault_auth_backend" "userpass" {
#   type = "userpass"
# }

# resource "vault_generic_endpoint" "admin_user" {
#   path                 = "auth/${vault_auth_backend.userpass.path}/users/nphilbrook"
#   ignore_absent_fields = true
#   data_json            = <<EOT
# {
#   "policies": ["hcp-root"],
#   "password": "${var.admin_userpass_password}"
# }
# EOT
# }
