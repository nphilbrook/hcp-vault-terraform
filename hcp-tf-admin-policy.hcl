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

# manage JWT auth mounts
path "sys/mounts/auth/jwt*" {
  capabilities = ["create", "read", "update", "list", "delete"]
}

# manage JWT auth for TF roles
path "auth/jwt/role/hcp-tf*" {
  capabilities = ["create", "read", "update", "list", "delete"]
}

# manage userpass auth mounts
path "sys/mounts/auth/userpass*" {
  capabilities = ["create", "read", "update", "list", "delete"]
}

# manage userpass users
path "auth/userpass/users*" {
  capabilities = ["create", "read", "update", "list", "delete"]
}

# manage policies for HCP TF
path "sys/policies/acl/hcp-tf-*" {
  capabilities = ["create", "read", "update", "list", "delete"]
}

# manage namespaces
path "sys/namespaces*" {
  capabilities = ["create", "read", "update", "list", "delete"]
}

