include "root" {
    path = find_in_parent_folders()
} 

include "envcommon" {
    path = "${dirname(find_in_parent_folders())}/_envcommon/security-group/security-group.hcl"
}

locals {
    
  # Extract out common variables for reuse
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))  

}

dependency "vpc" {
    config_path = "../vpc"
    mock_outputs = {
        vpc_id = "known after apply"
        #vpc_cidr_block = "0.0.0.0/0"
    }
}

# Indicate the input values to use for the variables of the module.
inputs = {
    name        = "training-ec2-sg"
    path        = "/"
    description = "security group for ec2"
    vpc_id      = dependency.vpc.outputs.vpc_id

    ingress = {
        description      = "TLS from VPC"
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = "0.0.0.0/0"
    }
    egress = {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = "0.0.0.0/0"
    }
}