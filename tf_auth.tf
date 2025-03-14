# To create this basic object prior to having dynamic auth in place in the workspace, use a short lived,
# hardcoded VAULT_TOKEN variable on the workspace

resource "vault_jwt_auth_backend" "jwt_hcp_tf" {
  description        = "JWT auth backend for HCP Terraform"
  path               = "jwt"
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer       = "https://app.terraform.io"
}

data "vault_policy_document" "hcp_tf_admin" {

  # AWS dynamic credentials - set this on a different role
  # rule {
  #   path         = "aws/*"
  #   capabilities = ["read"]
  # }

  # ======= JWT =============

  rule {
    path         = "sys/auth/jwt*"
    capabilities = ["create", "read", "update", "list", "delete", "sudo"]
    description  = "manage JWT auth mounts"
  }


  rule {
    path         = "sys/mounts/auth/jwt*"
    capabilities = ["create", "read", "update", "list", "delete", "sudo"]
    description  = "because we can't have nice things"
  }


  rule {
    path         = "auth/jwt/config*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage JWT config"
  }


  rule {
    path         = "auth/jwt/role/hcp-tf*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage JWT auth for TF roles"
  }
  # ======= END JWT =============

  # ======= USERPASS =============
  rule {
    path         = "sys/mounts/auth/userpass*"
    capabilities = ["create", "read", "update", "list", "delete", "sudo"]
    description  = "manage userpass auth mounts"
  }

  rule {
    path         = "sys/auth/userpass*"
    capabilities = ["create", "read", "update", "list", "delete", "sudo"]
  }


  rule {
    path         = "auth/userpass/users*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage userpass users"
  }
  # ======= END USERPASS =============


  rule {
    path         = "sys/policies/acl/hcp-tf-*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage policies for HCP TF"
  }

  rule {
    path         = "sys/namespaces*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage namespaces"
  }
}

resource "vault_policy" "hcp_tf_admin" {
  name   = "hcp-tf-admin"
  policy = data.vault_policy_document.hcp_tf_admin.hcl
}

resource "vault_jwt_auth_backend_role" "hcp_tf_admin" {
  backend        = vault_jwt_auth_backend.jwt_hcp_tf.path
  role_name      = "hcp-tf-admin"
  token_policies = ["default", vault_policy.hcp_tf_admin.name]

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    sub = "organization:philbrook:project:SB Vault Lab:workspace:hcp-vault-tf:run_phase:*"
  }
  bound_claims_type = "glob"
  user_claim        = "terraform_full_workspace"
  role_type         = "jwt"
}


resource "vault_jwt_auth_backend_role" "another" {
  backend        = vault_jwt_auth_backend.jwt_hcp_tf.path
  role_name      = "hcp-tf-admin-test"
  token_policies = []

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    sub = "organization:philbrook:project:SB Vault Lab:workspace:hcp-vault-tf:run_phase:*"
  }
  bound_claims_type = "glob"
  user_claim        = "terraform_full_workspace"
  role_type         = "jwt"
}


