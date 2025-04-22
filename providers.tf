provider "hcp" {
}

provider "vault" {
  address   = hcp_vault_cluster.cluster.vault_private_endpoint_url
  namespace = "admin"
}
