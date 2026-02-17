terraform {
  cloud {
    organization = "philbrook"

    workspaces {
      project = "SB Vault Lab"
      name    = "hcp-vault-terraform"
    }
  }
}
