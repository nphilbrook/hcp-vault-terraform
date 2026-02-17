resource "hcp_hvn" "hvn_dr" {
  hvn_id         = "vault-hvn-dr"
  cloud_provider = "aws"
  region         = local.dr_region
  cidr_block     = "10.3.0.0/16"
}

