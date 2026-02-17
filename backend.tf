terraform {
  cloud {
    organization = "philbrook"

    workspaces {
      project = "AWS Vault Lab"
      name    = "vault-aws-admin-terraform"
    }
  }
}
