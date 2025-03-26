resource "hcp_hvn" "hvn" {
  hvn_id         = "vault-hvn"
  cloud_provider = "aws"
  region         = "us-east-1"
  cidr_block     = "192.168.208.0/24"
}

resource "hcp_vault_cluster" "cluster" {
  cluster_id = "vault-cluster"
  hvn_id     = hcp_hvn.hvn.hvn_id
  tier       = "standard_large"
  # TBD
  # metrics_config {
  #   datadog_api_key = "test_datadog"
  #   datadog_region  = "us1"
  # }
  # audit_log_config {
  #   datadog_api_key = "test_datadog"
  #   datadog_region  = "us1"
  # }
  major_version_upgrade_config {
    upgrade_type = "MANUAL"
  }

  proxy_endpoint = "DISABLED"

  public_endpoint = false

  # ip_allowlist {
  #   address     = "35.166.217.52/32"
  #   description = "TFC agent"
  # }

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcp_aws_network_peering" "peering" {
  hvn_id          = hcp_hvn.hvn.hvn_id
  peering_id      = "vault-peering"
  peer_vpc_id     = "vpc-078b502573bace5cc"
  peer_account_id = "381492258979"
  peer_vpc_region = "us-east-1"
}

# Create routes from HVN to all RFC1918 addresses
locals {
  rfc1918_cidrs = {
    "classA"  = "10.0.0.0/8",
    "classBs" = "172.16.0.0/12",
    "classCs" = "192.168.0.0/16"
  }
}

resource "hcp_hvn_route" "route" {
  for_each         = local.rfc1918_cidrs
  hvn_link         = hcp_hvn.hvn.self_link
  hvn_route_id     = "vault-route-${each.key}"
  destination_cidr = each.value
  target_link      = hcp_aws_network_peering.peering.self_link
}
