provider "aws" {
  region = var.region
  profile = "mo-production"
}
terraform {
  required_version = ">= 0.12"
  backend "local" {
    path = "my-local-state.tfstate"
  }
}
