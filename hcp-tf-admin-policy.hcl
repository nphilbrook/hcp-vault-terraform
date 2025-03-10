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

# manage namespaces
path "sys/namespaces*" {
  capabilities = ["create", "read", "update", "list", "delete"]
}

