# resource "vault_aws_secret_backend" "aws" {
#   access_key = var.initial_aws_access_key_id
#   secret_key = var.initial_aws_secret_access_key
#   lifecycle {
#     ignore_changes = [
#       access_key,
#       secret_key
#     ]
#   }
# }

# resource "vault_aws_secret_backend_role" "probable_pancake_role" {
#   backend         = vault_aws_secret_backend.aws.path
#   name            = "probable-pancake-tf"
#   credential_type = "assumed_role"
#   role_arns       = ["arn:aws:iam::517068637116:role/dyn-ec2-access"]
# }

