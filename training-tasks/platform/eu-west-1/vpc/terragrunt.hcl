include "root" {
    path = find_in_parent_folders()
} 

include "envcommon" {
    path = "${dirname(find_in_parent_folders())}/_envcommon/vpc/vpc.hcl"
}

inputs = {

    cidr = "10.0.0.0/16"

    public_subnets = ["10.0.1.0/24","10.0.2.0/24"]
    private_subnets = ["10.0.3.0/24","10.0.4.0/24"] 
    
}