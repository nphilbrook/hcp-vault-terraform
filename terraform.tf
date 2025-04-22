terraform {
  required_version = ">=1.8"
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~>0.104.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~>4.6.0"
    }
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~>5.94"
    # }
  }
}
