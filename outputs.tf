output "vault_version" {
  description = "The Enterprise version of the HCP Vault Dedicated cluster"
  value       = hcp_vault_cluster.cluster.vault_version
}

output "private_endpoint_url" {
  description = "The private endpoint of the Vault cluster"
  value       = hcp_vault_cluster.cluster.vault_private_endpoint_url
}

output "namespace_path" {
  value = {
    for k, v in module.top_level_namespaces : k => v.path
  }
}

output "namespace_ids" {
  value = {
    for k, v in module.top_level_namespaces : k => v.id
  }
}

output "namespace_path_fq" {
  value = {
    for k, v in module.top_level_namespaces : k => v.path_fq
  }
}

output "provider_account_id" {
  description = "The Account ID hosting the HVN"
  value       = hcp_hvn.hvn.provider_account_id
}

# output "hcp_aws_transit_gateway_attachment_id" {
#   value = hcp_aws_transit_gateway_attachment.tgw_attachment.provider_transit_gateway_attachment_id
# }


# output "aws_caller_identity" {
#   value = data.aws_caller_identity.this
# }
