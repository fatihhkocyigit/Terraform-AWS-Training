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

    name                   = "training-instance-2"
    vpc_id                 = dependency.vpc.outputs.vpc_id
    ami                    = "ami-ebd02392"
    instance_type          = "t2.micro"
    #key_name               = "fatih-key"
    monitoring             = false
    vpc_security_group_ids = [dependency.security-group.outputs.security_group_id]
    subnet_id              = "subnet-06eb2e0a0f5449182" #[dependency.vpc.outputs.private_subnets[1]] 
}