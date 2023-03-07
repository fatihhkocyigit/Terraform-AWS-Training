terraform {
  source = "${dirname(find_in_parent_folders())}//infra-modules/terraform-aws-vpc"
}

locals {
# Automatically load environment-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))  

  # Extract out common variables for reuse
  region = local.region_vars.inputs.region

}

inputs = {
  name = "terraform-training-vpc"
  azs             = ["${local.region}a", "${local.region}b"]
  
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = true

  enable_dns_support   = true
  enable_dns_hostnames = true
}