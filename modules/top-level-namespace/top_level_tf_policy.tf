data "vault_policy_document" "hcp_tf_top_level" {
  # ======= CONFIGURE SAML AUTH =========
  rule {
    path         = "sys/auth/saml"
    capabilities = ["create", "read", "update", "patch", "list", "delete", "sudo"]
    description  = "manage SAML auth"
  }

  rule {
    path         = "sys/mounts/auth/saml"
    capabilities = ["create", "read", "update", "patch", "list", "delete", "sudo"]
    description  = "because we can't have nice things"
  }

  rule {
    path         = "auth/saml/config"
    capabilities = ["create", "read", "update", "patch", "list", "delete"]
    description  = "manage SAML auth configuration"
  }

  rule {
    path         = "auth/saml/role*"
    capabilities = ["create", "read", "update", "patch", "list", "delete"]
    description  = "manage SAML authroles"
  }
  # ======= END SAML =========

  # ======= IDENTITY (entities, groups, aliases) =================
  rule {
    path         = "identity/group*"
    capabilities = ["create", "read", "update", "patch", "list", "delete"]
    description  = "manage identity groups and aliases"
  }
  # ======= END IDENTITY ==============================

  # ======= Manage Namespaces =============
  rule {
    path         = "sys/namespaces*"
    capabilities = ["create", "read", "update", "patch", "list", "delete"]
    description  = "manage namespaces"
  }
  # ========= Manage JWT auth and policies in BU namespaces ========
  rule {
    path         = "+/sys/auth/jwt*"
    capabilities = ["create", "read", "update", "patch", "list", "delete", "sudo"]
    description  = "manage JWT auth mounts"
  }

  rule {
    path         = "+/sys/mounts/auth/jwt*"
    capabilities = ["create", "read", "update", "patch", "list", "delete", "sudo"]
    description  = "Alternate path sometimes used by Vault provider"
  }

  rule {
    path         = "+/auth/jwt/config*"
    capabilities = ["create", "read", "update", "patch", "list", "delete"]
    description  = "manage JWT config"
  }

  rule {
    path         = "+/auth/jwt/role/hcp-tf*"
    capabilities = ["create", "read", "update", "patch", "list", "delete"]
    description  = "manage JWT auth for TF roles"
  }

  rule {
    path         = "+/sys/policies/acl/hcp-tf-*"
    capabilities = ["create", "read", "update", "patch", "list", "delete"]
    description  = "manage policies for HCP TF"
  }

  rule {
    path         = "+/sys/policies/acl/break-glass"
    capabilities = ["create", "read", "update", "patch", "list", "delete"]
    description  = "manage the break glass policy"
  }
  # ========= End Manage JWT auth and policies in BU namespaces ========

  # ======= mounts management ===========
  # This will cover enabling all types of secrets mounts - kv, aws, db, etc.
  rule {
    path         = "+/sys/mounts*"
    capabilities = ["create", "read", "update", "patch", "list", "delete"]
    description  = "manage all secret mounts"
  }
  # ======= end mounts management ===========

  # ======= AWS secrets engine setup in BU namespace =========
  rule {
    path         = "+/aws/config/root"
    capabilities = ["create", "read", "update", "patch", "list", "delete"]
    description  = "manage AWS secrets mount config"
  }

  rule {
    path         = "+/aws/roles*"
    capabilities = ["create", "read", "update", "patch", "list", "delete"]
    description  = "manage AWS roles"
  }

  rule {
    path         = "+/sys/policies/acl/aws-*"
    capabilities = ["create", "read", "update", "patch", "list", "delete"]
    description  = "manage policies for dynamic AWS credentials (prefix by convention)"
  }
  # ======= End AWS secrets engine setup =========
}
