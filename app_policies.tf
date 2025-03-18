data "vault_policy_document" "probable_pancake" {
  rule {
    path         = "aws/creds/${vault_aws_secret_backend_role.probable_pancake_role.name}"
    capabilities = ["read"]
    description  = "Read dynamic AWS credentials for the specified role"
  }
}
