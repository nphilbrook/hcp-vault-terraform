provider "hcp" {
}

provider "vault" {
  address   = "https://vault-cluster-private-vault-e9bf486c.f4702644.z1.hashicorp.cloud:8200"
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

