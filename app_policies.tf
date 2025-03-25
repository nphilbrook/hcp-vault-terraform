# data "vault_policy_document" "probable_pancake" {
#   rule {
#     path         = "aws/creds/${vault_aws_secret_backend_role.probable_pancake_role.name}"
#     capabilities = ["read"]
#     description  = "Read dynamic AWS credentials for the specified role"
#   }

#   rule {
#     path         = "aws/sts/${vault_aws_secret_backend_role.probable_pancake_role.name}"
#     capabilities = ["read", "update", "create"]
#     description  = "Read dynamic AWS credentials for the specified role with the STS path."
#   }
# }
