data "vault_policy_document" "hcp_tf_top_level" {
  # ======= JWT =============
  # Do actually need these? Or just on the child namespaces...
  # rule {
  #   path         = "sys/auth/jwt*"
  #   capabilities = ["create", "read", "update", "list", "delete", "sudo"]
  #   description  = "manage JWT auth mounts"
  # }

  # rule {
  #   path         = "sys/mounts/auth/jwt*"
  #   capabilities = ["create", "read", "update", "list", "delete", "sudo"]
  #   description  = "because we can't have nice things"
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
  # ========= Manage JWT auth in BU namespaces ========

  # ========= End Manage JWT auth in BU namespaces ========
}
