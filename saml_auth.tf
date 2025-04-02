locals {
  saml_mount = "saml"
}

resource "vault_saml_auth_backend" "auth0" {
  path             = local.saml_mount
  idp_metadata_url = "https://dev-duhq6zvtxhjtgss0.us.auth0.com/samlp/metadata/djIEvjayGHtOJsVaaZwOWhiHvQkmaSob"
  entity_id        = "${hcp_vault_cluster.cluster.vault_private_endpoint_url}/v1/auth/saml"
  acs_urls         = ["${hcp_vault_cluster.cluster.vault_private_endpoint_url}/v1/admin/auth/saml/callback"]
  default_role     = "default"
}

resource "vault_saml_auth_backend_role" "default" {
  path             = vault_saml_auth_backend.auth0.path
  name             = "default"
  token_policies   = ["default"]
  groups_attribute = "http://schemas.auth0.com/vault-roles"
}

resource "vault_saml_auth_backend_role" "hcp_root" {
  path           = vault_saml_auth_backend.auth0.path
  name           = "vault-super-admin"
  token_policies = ["hcp-root"]
  bound_attributes = {
    "http://schemas.auth0.com/vault-super-admin" = "true"
  }
}

# External group for admins
resource "vault_identity_group" "superadmin" {
  name     = "superadmin"
  type     = "external"
  policies = ["hcp-tf-admin"]
}

data "vault_generic_secret" "saml_mount" {
  path = "sys/auth/${local.saml_mount}"
}

resource "vault_identity_group_alias" "superadmin_alias" {
  name           = "vault-admin"
  mount_accessor = data.vault_generic_secret.saml_mount.data.accessor
  canonical_id   = vault_identity_group.superadmin.id
}
