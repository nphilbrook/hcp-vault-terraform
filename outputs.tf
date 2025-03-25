output "vault_version" {
  description = "The Enterprise version of the HCP Vault Dedicated cluster"
  value       = hcp_vault_cluster.cluster.vault_version
}

output "private_endpoint_url" {
  description = "The private endpoint of the Vault cluster"
  value       = hcp_vault_cluster.cluster.vault_private_endpoint_url
}

output "namespace_ids" {
  value = vault_namespace.top_level_namespaces[*].id
}

output "namespace_fq" {
  value = vault_namespace.top_level_namespaces[*].path_fq
}

