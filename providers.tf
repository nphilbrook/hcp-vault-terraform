provider "vault" {
  # Env variables should fill these in
  # address   = 
  # namespace = "admin"
}

locals {
  tags_labels = {
    "created-by"       = "terraform",
    "source-workspace" = var.TFC_WORKSPACE_SLUG
  }
}

# provider "aws" {
#   region = local.region
#   default_tags {
#     tags = local.tags_labels
#   }
# }

