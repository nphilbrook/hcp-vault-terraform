locals {
  top_level_namespaces = toset([
    "testing",
    "live"
  ])
}

module "top_level_namespaces" {
  for_each = local.top_level_namespaces
  source   = "./modules/top-level-namespace"
  name     = each.value
}
