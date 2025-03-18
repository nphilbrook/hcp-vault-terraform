data "vault_policy_document" "probable_pancake" {
  rule {
    path         = "aws/creds/probable-pancake-tf"
    capabilities = ["read"]
    description  = "Read dynamic AWS credentials for the specified role"
  }
}
