provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

provider "aws" {
  access_key = "AKIATWDEXRPRRFMNC2PJ"
  secret_key = "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"
  region = var.region
}


data "aws_availability_zones" "available" {}

locals {
  cluster_name = "yogitest-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}
