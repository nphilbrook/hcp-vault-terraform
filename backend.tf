terraform {
  cloud {
    organization = "bankunited-core"

    workspaces {
      project = "Vault Admin"
      name    = "hcp-vault-terraform"
    }
  }
}
