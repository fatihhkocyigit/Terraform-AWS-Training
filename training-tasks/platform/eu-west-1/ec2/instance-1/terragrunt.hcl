include "root" {
    path = find_in_parent_folders()
} 

include "envcommon" {
    path = "${dirname(find_in_parent_folders())}/_envcommon/ec2/ec2.hcl"
}

locals {
    
  # Extract out common variables for reuse
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))  

}

dependency "security-group" {
    config_path = "../../security-group"
    mock_outputs = {
        security_group_id = "known after apply"
    }
}

dependency "vpc" {
    config_path = "../../vpc"
    mock_outputs = {
        vpc_id = "known after apply"
        vpc_cidr_block = "0.0.0.0/0"
        private_subnets = "known after apply"
    }
}

inputs = {
    create = true
    name                   = "training-instance-1"
    vpc_id                 = dependency.vpc.outputs.vpc_id
    ami                    = "ami-047bb4163c506cd98"
    instance_type          = "t2.micro"
    #key_name               = "fatih-key" # LOOK OUT
    monitoring             = false
    vpc_security_group_ids = [dependency.security-group.outputs.security_group_id]
    subnet_id              = "subnet-0d0361bf999eac99d"#[dependency.vpc.outputs.private_subnets[0]] #TODO
}