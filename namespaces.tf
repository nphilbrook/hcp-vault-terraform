resource "vault_namespace" "hcp_tf_aws" {
  path = "hcp-tf-aws"
}

resource "vault_namespace" "integrations" {
  path = "integrations"
}
