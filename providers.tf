terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~>0.104.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~>4.6.0"
    }
  }
}

provider "hcp" {
}

provider "vault" {
  address   = "https://vault-cluster-private-vault-e9bf486c.f4702644.z1.hashicorp.cloud:8200"
  namespace = "admin"
}
