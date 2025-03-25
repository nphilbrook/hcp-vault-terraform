resource "vault_namespace" "top_level_namespaces" {
  for_each = local.top_level_namespaces
  path     = each.value
}
