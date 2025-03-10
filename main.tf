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

resource "hcp_hvn_route" "route" {
  hvn_link         = hcp_hvn.hvn.self_link
  hvn_route_id     = "vault-route"
  destination_cidr = "172.31.0.0/16"
  target_link      = hcp_aws_network_peering.peering.self_link
}
