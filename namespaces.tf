locals {
  top_level_namespaces = toset([
    "testing",
    "live"
  ])
}

resource "vault_namespace" "top_level_namespaces" {
  for_each = local.top_level_namespaces
  path     = each.value
}
