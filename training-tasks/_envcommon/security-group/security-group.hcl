terraform {
    source = "${dirname(find_in_parent_folders())}//infra-modules/terraform-aws-security-group"
}

locals {
# Automatically load environment-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))  

  # Extract out common variables for reuse
  region = local.region_vars.inputs.region
  
}

inputs = {

}