locals {
  top_level_namespaces = toset([
    "testing",
    "live"
  ])
}

resource "vault_namespace" "top_level_namespaces" {
  for_each = local.top_level_namespaces
  path     = each.value
  # Prevent accidental destruction - must be removed prior to any
  # change that would cause destruction
  lifecycle {
    prevent_destroy = true
  }
}
