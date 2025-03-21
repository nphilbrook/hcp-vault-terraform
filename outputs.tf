output "vault_version" {
  description = "The Enterprise version of the HCP Vault Dedicated cluster"
  value       = hcp_vault_cluster.cluster.vault_version
}

output "private_endpoint_url" {
  description = "The private endpoint of the Vault cluster"
  value       = hcp_vault_cluster.cluster.vault_private_endpoint_url
}
