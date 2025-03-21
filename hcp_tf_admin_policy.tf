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


  # ======= AWS secrets engine setup =========
  rule {
    path         = "sys/mounts/aws"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage AWS secrets mount"
  }

  rule {
    path         = "aws/config/root"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage AWS secrets mount config"
  }

  rule {
    path         = "aws/roles*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage AWS roles"
  }
  # ======= End AWS secrets engine setup =========

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
    path         = "sys/policies/acl/aws-*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage policies for dynamic AWS credentials (prefix by convention)"
  }

  rule {
    path         = "sys/namespaces*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage namespaces"
  }
}

