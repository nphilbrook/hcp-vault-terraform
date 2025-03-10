output "vault_version" {
  description = "The Enterprise version of the HCP Vault Dedicated cluster"
  value       = hcp_vault_cluster.cluster.vault_version
}
