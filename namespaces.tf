resource "vault_namespace" "hcp_tf_testing" {
  path = "testing"
}

resource "vault_namespace" "live" {
  path = "live"
}

