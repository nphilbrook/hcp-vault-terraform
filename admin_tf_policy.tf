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

  # ======= CONFIGURE SAML AUTH =========
  rule {
    path         = "sys/auth/saml"
    capabilities = ["create", "read", "update", "list", "delete", "sudo"]
    description  = "manage SAML auth"
  }

  rule {
    path         = "sys/mounts/auth/saml"
    capabilities = ["create", "read", "update", "list", "delete", "sudo"]
    description  = "because we can't have nice things"
  }

  rule {
    path         = "auth/saml/config"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage SAML auth configuration"
  }

  rule {
    path         = "auth/saml/role*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage SAML authroles"
  }
  # ======= END SAML =========

  # ======= IDENTITY =================
  rule {
    path         = "identity/group*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage identity groups and aliases"
  }
  # ======= END IDENTITY =============

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

# Separate policy to manage Objects within the 2 top-level namespaces
data "vault_policy_document" "hcp_tf_admin_top_level_management" {

  # ======= JWT =============
  rule {
    path         = "+/sys/auth/jwt*"
    capabilities = ["create", "read", "update", "list", "delete", "sudo"]
    description  = "manage JWT auth mounts"
  }

  rule {
    path         = "+/sys/mounts/auth/jwt*"
    capabilities = ["create", "read", "update", "list", "delete", "sudo"]
    description  = "Alternate path sometimes used by Vault provider"
  }

  rule {
    path         = "+/auth/jwt/config*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage JWT config"
  }

  rule {
    path         = "+/auth/jwt/role/hcp-tf*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage JWT auth for TF roles"
  }
  # ======= END JWT =============

  # ======= Manage Policies =============
  rule {
    path         = "+/sys/policies/acl/hcp-tf-*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage policies for HCP TF"
  }
  # ======= End Manage Policies =============
}
