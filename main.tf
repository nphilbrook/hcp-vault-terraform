resource "hcp_hvn" "hvn" {
  hvn_id         = "vault-hvn"
  cloud_provider = "aws"
  region         = "us-west-2"
  cidr_block     = "10.2.0.0/16"
}

resource "hcp_vault_cluster" "cluster" {
  cluster_id = "vault-cluster"
  hvn_id     = hcp_hvn.hvn.hvn_id
  tier       = "standard_large"
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

  # Prevent accidental destruction - must be removed prior to any
  # change that would cause destruction
  lifecycle {
    prevent_destroy = true
  }
}

resource "hcp_aws_network_peering" "peering" {
  hvn_id          = hcp_hvn.hvn.hvn_id
  peering_id      = "vault-peering"
  peer_vpc_id     = "vpc-0b70cc11123de0961"
  peer_account_id = "590184029125"
  peer_vpc_region = "us-west-2"
}

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
