provider "hcp" {}

provider "vault" {
  address   = hcp_vault_cluster.cluster.vault_private_endpoint_url
  namespace = "admin"
}

locals {
  tags_labels = {
    "created-by"       = "terraform",
    "source-workspace" = var.TFC_WORKSPACE_SLUG
  }
}

provider "aws" {
  region = local.region
  default_tags {
    tags = local.tags_labels
  }
}

