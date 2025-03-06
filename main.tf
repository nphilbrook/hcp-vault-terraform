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
  lifecycle {
    prevent_destroy = true
  }
}
