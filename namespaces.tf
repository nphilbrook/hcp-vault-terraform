resource "vault_namespace" "ns1" {
  path = "hcp-tf-aws"
}

resource "vault_namespace" "ns2" {
  path = "application-dev"
}
