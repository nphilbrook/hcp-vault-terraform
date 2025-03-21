resource "vault_saml_auth_backend" "auth0" {
  path             = "saml"
  idp_metadata_url = "https://dev-duhq6zvtxhjtgss0.us.auth0.com/samlp/metadata/djIEvjayGHtOJsVaaZwOWhiHvQkmaSob"
  entity_id        = "${hcp_vault_cluster.cluster.vault_private_endpoint_url}/v1/auth/saml"
  acs_urls         = ["${hcp_vault_cluster.cluster.vault_private_endpoint_url}/v1/admin/auth/saml/callback"]
  default_role     = "default"
}

resource "vault_saml_auth_backend_role" "default" {
  path           = vault_saml_auth_backend.auth0.path
  name           = "default"
  token_policies = ["default"]
}
