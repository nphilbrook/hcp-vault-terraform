# Allow tokens to query themselves
path "auth/token/lookup-self" {
  capabilities = ["read"]
}

# Allow tokens to renew themselves
path "auth/token/renew-self" {
    capabilities = ["update"]
}

# Allow tokens to revoke themselves
path "auth/token/revoke-self" {
    capabilities = ["update"]
}

# AWS dynamic credentials - set this on a different role
# path "aws/*" {
#   capabilities = ["read"]
# }

# ======= JWT =============

# manage JWT auth mounts
path "sys/auth/jwt*" {
  capabilities = ["create", "read", "update", "list", "delete", "sudo"]
}

# because we can't have nice things
path "sys/mounts/auth/jwt*" {
  capabilities = ["create", "read", "update", "list", "delete", "sudo"]
}

# manage JWT config
path "auth/jwt/config*" {
  capabilities = ["create", "read", "update", "list", "delete"]
}

# manage JWT auth for TF roles
path "auth/jwt/role/hcp-tf*" {
  capabilities = ["create", "read", "update", "list", "delete"]
}
# ======= END JWT =============

# ======= USERPASS =============
# manage userpass auth mounts
path "sys/mounts/auth/userpass*" {
  capabilities = ["create", "read", "update", "list", "delete", "sudo"]
}

path "sys/auth/userpass*" {
  capabilities = ["create", "read", "update", "list", "delete", "sudo"]
}

# manage userpass users
path "auth/userpass/users*" {
  capabilities = ["create", "read", "update", "list", "delete"]
}
# ======= END USERPASS =============

# manage policies for HCP TF
path "sys/policies/acl/hcp-tf-*" {
  capabilities = ["create", "read", "update", "list", "delete"]
}

# manage namespaces
path "sys/namespaces*" {
  capabilities = ["create", "read", "update", "list", "delete"]
}

