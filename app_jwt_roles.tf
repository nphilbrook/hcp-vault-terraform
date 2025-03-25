# resource "vault_policy" "probable_pancake" {
#   name = "aws-probable-pancake"
#   # ref app_policies.tf
#   policy = data.vault_policy_document.probable_pancake.hcl
# }

# resource "vault_jwt_auth_backend_role" "probable_pancake" {
#   backend        = vault_jwt_auth_backend.jwt_hcp_tf.path
#   role_name      = "hcp-tf-probable-pancake"
#   token_policies = ["default", vault_policy.probable_pancake.name]

#   bound_audiences = ["vault.workload.identity"]
#   bound_claims = {
#     sub = "organization:philbrook:project:SB Vault Lab:workspace:aws-probable-pancake:run_phase:*"
#   }
#   bound_claims_type = "glob"
#   user_claim        = "terraform_full_workspace"
#   role_type         = "jwt"
# }
