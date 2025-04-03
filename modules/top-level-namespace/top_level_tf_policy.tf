data "vault_policy_document" "hcp_tf_top_level" {
  # ======= JWT =============
  # Do we actually need these? Or just on the child namespaces...
  # rule {
  #   path         = "sys/auth/jwt*"
  #   capabilities = ["create", "read", "update", "list", "delete", "sudo"]
  #   description  = "manage JWT auth mounts"
  # }

  # rule {
  #   path         = "sys/mounts/auth/jwt*"
  #   capabilities = ["create", "read", "update", "list", "delete", "sudo"]
  #   description  = "Alternate path sometimes used by Vault provider"
  # }

  # rule {
  #   path         = "auth/jwt/config*"
  #   capabilities = ["create", "read", "update", "list", "delete"]
  #   description  = "manage JWT config"
  # }

  # rule {
  #   path         = "auth/jwt/role/hcp-tf*"
  #   capabilities = ["create", "read", "update", "list", "delete"]
  #   description  = "manage JWT auth for TF roles"
  # }
  # ======= END JWT =============

  # ======= Manage Policies =============
  # same question...
  # rule {
  #   path         = "sys/policies/acl/hcp-tf-*"
  #   capabilities = ["create", "read", "update", "list", "delete"]
  #   description  = "manage policies for HCP TF"
  # }
  # ======= End Manage Policies =============

  # ======= Manage Namespaces =============
  rule {
    path         = "sys/namespaces*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage namespaces"
  }
  # ========= Manage JWT auth and policies in BU namespaces ========
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

  rule {
    path         = "+/sys/policies/acl/hcp-tf-*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage policies for HCP TF"
  }
  # ========= End Manage JWT auth and policies in BU namespaces ========

  # ======= AWS secrets engine setup in BU namespace =========
  rule {
    path         = "+/sys/mounts/aws"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage AWS secrets mount"
  }

  rule {
    path         = "+/aws/config/root"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage AWS secrets mount config"
  }

  rule {
    path         = "+/aws/roles*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage AWS roles"
  }

  rule {
    path         = "+/sys/policies/acl/aws-*"
    capabilities = ["create", "read", "update", "list", "delete"]
    description  = "manage policies for dynamic AWS credentials (prefix by convention)"
  }
  # ======= End AWS secrets engine setup =========
}
