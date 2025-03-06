terraform {
  cloud {
    organization = "philbrook"

    workspaces {
      name = "hcp-vault-tf"
    }
  }
}
