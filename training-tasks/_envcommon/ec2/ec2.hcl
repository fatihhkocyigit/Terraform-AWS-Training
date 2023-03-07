terraform {
    source = "${dirname(find_in_parent_folders())}//infra-modules/terraform-aws-ec2-instance-master"
    #source = "https://github.com/fatihhkocyigit/Terraform-AWS-Training/tree/master/training-tasks/infra-modules/terraform-aws-ec2-instance-master"
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