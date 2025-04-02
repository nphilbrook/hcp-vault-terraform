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

# It's insnane that we have to do this
data "vault_generic_secret" "saml_mount" {
  path = "sys/auth/${local.saml_mount}"
}

resource "vault_saml_auth_backend_role" "default" {
  path             = vault_saml_auth_backend.auth0.path
  name             = "default"
  token_policies   = ["default"]
  groups_attribute = "http://schemas.auth0.com/vault-roles"
}

# break glass super admin
resource "vault_saml_auth_backend_role" "hcp_root" {
  path             = vault_saml_auth_backend.auth0.path
  name             = "vault-super-admin"
  token_policies   = ["hcp-root"]
  groups_attribute = "http://schemas.auth0.com/vault-roles"
  bound_attributes = {
    "http://schemas.auth0.com/vault-super-admin" = "true"
  }
}

# External group for admins
resource "vault_identity_group" "regular_admin" {
  name     = "superadmin"
  type     = "external"
  policies = ["hcp-tf-admin"]
}

resource "vault_identity_group_alias" "regular_admin_alias" {
  name           = "vault-admin"
  mount_accessor = data.vault_generic_secret.saml_mount.data.accessor
  canonical_id   = vault_identity_group.regular_admin.id
}

resource "vault_identity_group" "cloud_operations_read" {
  name     = "Cloud-Operations-Read"
  type     = "external"
  policies = ["Cloud-Operations-Read"]
}

resource "vault_identity_group_alias" "cloud_operatinrs_alias" {
  name           = "Cloud-Operations-Read"
  mount_accessor = data.vault_generic_secret.saml_mount.data.accessor
  canonical_id   = vault_identity_group.cloud_operations_read.id
}
