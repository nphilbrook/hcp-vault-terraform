resource "hcp_hvn" "hvn" {
  hvn_id         = "vault-hvn"
  cloud_provider = "aws"
  region         = local.region
  cidr_block     = "10.2.0.0/16"
}

resource "hcp_vault_cluster" "cluster" {
  cluster_id = "vault-cluster"
  hvn_id     = hcp_hvn.hvn.hvn_id
  tier       = "standard_large"
  # metrics_config {
  #   cloudwatch_access_key_id     = aws_iam_access_key.metrics_key.id
  #   cloudwatch_secret_access_key = aws_iam_access_key.metrics_key.secret
  #   cloudwatch_region            = local.region
  # }
  audit_log_config {
    cloudwatch_access_key_id     = aws_iam_access_key.audit_logs_key.id
    cloudwatch_secret_access_key = aws_iam_access_key.audit_logs_key.secret
    cloudwatch_region            = local.region
  }
  major_version_upgrade_config {
    upgrade_type = "MANUAL"
  }

  proxy_endpoint = "ENABLED"

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

resource "hcp_hvn_route" "vpc_route" {
  hvn_link         = hcp_hvn.hvn.self_link
  hvn_route_id     = "vault-route-w2-vpc"
  destination_cidr = "172.31.0.0/16"
  target_link      = hcp_aws_network_peering.peering.self_link
}


# Transit Gateway Attachments for us-west-2

# resource "hcp_aws_transit_gateway_attachment" "tgw_attachment" {
#   hvn_id                        = hcp_hvn.hvn.hvn_id
#   transit_gateway_attachment_id = "tgw-attachment-w2"
#   transit_gateway_id            = "tgw-0ed725f6387afbe0a"
#   resource_share_arn            = "arn:aws:ram:us-west-2:590184029125:resource-share/850c67fe-69af-44e1-868a-b1c1c2a339b1"
# }

# resource "hcp_hvn_route" "tgw_route" {
#   hvn_link         = hcp_hvn.hvn.self_link
#   hvn_route_id     = "hvn-to-tgw-w2"
#   destination_cidr = "10.0.0.0/8"
#   target_link      = hcp_aws_transit_gateway_attachment.tgw_attachment.self_link
# }
