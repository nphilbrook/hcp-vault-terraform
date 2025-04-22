# To create these basic object prior to having dynamic auth in place in the workspace, use a short lived,
# hardcoded VAULT_TOKEN variable on the workspace

resource "vault_jwt_auth_backend" "jwt_hcp_tf" {
  description        = "JWT auth backend for HCP Terraform"
  path               = "jwt"
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer       = "https://app.terraform.io"
}

resource "vault_policy" "hcp_tf_admin" {
  name = "hcp-tf-admin"
  # ref admin_tf_admin_policy.tf
  policy = data.vault_policy_document.hcp_tf_admin.hcl
}

resource "vault_policy" "hcp_tf_admin_top_level_management" {
  name = "hcp-tf-admin-top-level-mgmt"
  # ref admin_tf_admin_policy.tf
  policy = data.vault_policy_document.hcp_tf_admin_top_level_management.hcl
}

# This role will be used by the code in *this workspace*
resource "vault_jwt_auth_backend_role" "hcp_tf_admin" {
  backend        = vault_jwt_auth_backend.jwt_hcp_tf.path
  role_name      = "hcp-tf-admin"
  token_policies = ["default", vault_policy.hcp_tf_admin.name, vault_policy.hcp_tf_admin_top_level_management.name]

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    sub = "organization:bankunited-core:project:*:workspace:hcp-vault-terraform:run_phase:*"
  }
  bound_claims_type = "glob"
  user_claim        = "terraform_full_workspace"
  role_type         = "jwt"
}
