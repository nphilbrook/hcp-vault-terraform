data "vault_policy_document" "hcp_tf_admin" {
  # ======= JWT =============
  rule {
    path         = "sys/auth/jwt*"
    capabilities = ["create", "read", "update", "list", "delete", "sudo"]
    description  = "manage JWT auth mounts"
  }

  rule {
    path         = "sys/mounts/auth/jwt*"
    capabilities = ["create", "read", "update", "list", "delete", "sudo"]
    description  = "Alternate path sometimes used by Vault provider"
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

  # ======= CONFIGURE OIDC AUTH =========
  rule {
    path         = "sys/auth/oidc"
    capabilities = ["create", "read", "update", "list", "delete", "sudo"]
    description  = "manage OIDC auth"
  }

  rule {
    path         = "sys/mounts/auth/oidc"
    capabilities = ["create", "read", "update", "list", "delete", "sudo"]
    description  = "because we can't have nice things"
  }

  rule {
    path         = "auth/oidc/config"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage OIDC auth configuration"
  }

  rule {
    path         = "auth/oidc/role*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage OIDC authroles"
  }
  # ======= END OIDC =========

  # ======= IDENTITY =================
  rule {
    path         = "identity/group*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage identity groups and aliases"
  }
  # ======= END IDENTITY =============

  # ======= Manage Policies =============
  rule {
    path         = "sys/policies/acl/hcp-tf-*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage policies for HCP TF"
  }
  # ======= End Manage Policies =============

  rule {
    path         = "sys/namespaces*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage namespaces"
  }
}
