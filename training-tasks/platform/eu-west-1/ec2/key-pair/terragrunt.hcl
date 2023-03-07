include "root" {
    path = find_in_parent_folders()
} 

include "envcommon" {
    path = "${dirname(find_in_parent_folders())}/_envcommon/ec2/key-pair.hcl"
}

locals {
    
  # Extract out common variables for reuse
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))  

}

inputs = {
    key_name           = "training-keys" 
    create_private_key = true
}