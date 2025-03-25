data "vault_policy_document" "hcp_tf_top_level" {
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

  rule {
    path         = "sys/policies/acl/aws-*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage policies for dynamic AWS credentials (prefix by convention)"
  }
  # ======= End Manage Policies =============

  # ======= Manage Namespaces =============
  rule {
    path         = "sys/namespaces*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage namespaces"
  }
}

