
module "eks-test" {
  azs = "a,b"
  cidr = "192.198.4.0/23"
  environment = "test"
  project = "eks"
  region = "us-east-1"
  source = "./eks"
  newbits = 2
}
output "config_map" {
  value = module.eks-test.certificate_data
}
