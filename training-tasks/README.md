# AWS Terragrunt Training Repository


Terraform Repository For AWS Training via using Terragrunt.


## Scope

The purpose of the project is to create re-usable AWS infrastructure with an IaC approach using Terraform and Terragrunt.It is important to understand the fundamentals and milestones of Terraform and Terragrunt to understand the this project.

- [Terraform Docs](https://www.terraform.io/docs)
- [Terragrunt Docs](https://terragrunt.gruntwork.io/docs/)


### Pre-requisites

1. Install [Terraform](https://www.terraform.io/) version `1.2.0` or newer and
   [Terragrunt](https://github.com/gruntwork-io/terragrunt) version `v0.38.0` or newer.
2. Configure your AWS credentials using one of the supported [authentication
   mechanisms](https://www.terraform.io/docs/providers/aws/#authentication).  Account you configured must have the permission to assume a role on the account that will be used for terraform operations.
3. Fill in your AWS Account ID's in `<environment>/account.hcl` which will be assumed for the terraform operations.


## Folder Structure

The code in this repo uses the following folder hierarchy:

```
root
 └ _envcommon
 └ environment
    └ env.hcl
    └ account.hcl
    └ region
       └ region.hcl
       └ resource
```

Where:

* **Root Level**: At the top level are each of your Folders, such as `stage`, `prod`, `platform`,
  etc. There is also be a `_envcommon` folder
  that defines resources that are available across all the environments for all continents.

* **Environment**: Within each environment you can deploy all the resources for that regions and there will be one or more `region`, such as `eu-west-1`, `eu-west-2`, etc. Typically,
  an environment will correspond to a single `CMS Environment`, which
  isolates that environment from everything else in the other environments. There is also be  `account.hcl` and `env.hcl` files that defines account and environment level variables.
* **Region**: Within each region, you can deploy all the resources for that region, such as VPC, ECS Clusters, Databases, Load Balancers, and so on. There is also be  `region.hcl` file that defines region level variables.
* **AWS_Resource**: Within each Resource, you can deploy the specific resource for that AWS Region.

## How do you deploy the infrastructure in this repo?

### Deploying a single module for resources

1. `cd` into the module's folder (e.g. `cd platform/eu-west-1/vpc`).
2. Run `terragrunt plan` to see the changes you're about to apply.
3. If the plan looks good, run `terragrunt apply`, then verify the apply command by pressing `y`.

* You have to configre `TF_VAR_atlas_public_key` and `TF_VAR_atlas_private_key`for applying mongodbatlas module.

### Deploying all modules in a region

1. `cd` into the region folder (e.g. `cd platform/eu-west-1`).
2. Run `terragrunt run-all plan` to see all the changes you're about to apply.
3. If the plan looks good, run `terragrunt run-all apply`, then verify the apply command by pressing `y`.

### Deploying all modules in a environment

1. `cd` into the region folder (e.g. `cd platform`).
2. Run `terragrunt run-all plan` to see all the changes you're about to apply.
3. If the plan looks good, run `terragrunt run-all apply`, then verify the apply command by pressing `y`.

## VPC

1. `cd` into the module's folder (e.g. `cd platform/eu-west-1/vpc`).
2. Run `terragrunt run-all plan` to see the changes you're about to apply.
3. If the plan looks good, run `terragrunt run-all apply`.

With this module, VPC, subnets, internat gateway, NAT gateway resources which are required for compute resources can be created

## EC2

1. `cd` into the module's folder (e.g. `cd platform/eu-west-1/ec-2`, `cd platform/eu-west-1/ec-2/instance1` or `cd platform/eu-west-1/ec-2/instance2` ).
2. Run `terragrunt run-all plan` to see the changes you're about to apply.
3. If the plan looks good, run `terragrunt run-all apply`.

This module has dependencies to security group and VPC to launch inctane in it. 

## Security Group

1. `cd` into the module's folder (e.g. `cd platform/eu-west-1/security_group`).
2. Run `terragrunt run-all plan` to see the changes you're about to apply.
3. If the plan looks good, run `terragrunt run-all apply`.

With this module, security groups and rules can be created for EC2 instance

## Key Pair

1. `cd` into the module's folder (e.g. `cd platform/eu-west-1/ec2/key-pair`).
2. Run `terragrunt run-all plan` to see the changes you're about to apply.
3. If the plan looks good, run `terragrunt run-all apply`.

With this module, EC2 key-pairs can be created for EC2 instance

## Modules
- [VPC Module](https://github.com/fatihhkocyigit/Terraform-AWS-Training/tree/master/training-tasks/infra-modules/terraform-aws-vpc)
- [EC2](https://github.com/fatihhkocyigit/Terraform-AWS-Training/tree/master/training-tasks/infra-modules/terraform-aws-ec2-instance-master)
- [Security Groups](https://github.com/fatihhkocyigit/Terraform-AWS-Training/tree/master/training-tasks/infra-modules/terraform-aws-security-group)
- [EC2 Key Pair](https://github.com/fatihhkocyigit/Terraform-AWS-Training/tree/master/training-tasks/infra-modules/terraform-aws-key-pair-master)

