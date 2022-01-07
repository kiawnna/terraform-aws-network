# terraform-aws-network
A secure, best-practice module that creates all basic resources needed for networking in AWS. It is opinionated and made so that it can be easily deployed.

## Instantiation
The simplest instantiation requires only an environment.

```
module "network" {
  source = "git@github.com:kiawnna/terraform-aws-network.git"
  environment = "dev"
}
```

## Resources Created
* A virtual private cloud
* Two public subnets
* Two private subnets
* An internet gateway
* A NAT gateway
* A public route table
* A private route table

## Outputs
The vpc, all subnets, and internet gateway ids can be accessed as outputs. 
Reference them as:

> module.network_module_name.vpc_id
> 
> module.network_module_name.public_subnet_id1
> 
> module.network_module_name.public_subnet_id2
> 
> module.network_module_name.private_subnet_id1
> 
> module.network_module_name.private_subnet_id2
> 
> module.network_module_name.internet_gateway_id

## Variables / Customization
Cidr blocks can be customized. Defaults are:
* vpc &rarr; "10.200.0.0/16"
* public subnet 1 &rarr; "10.200.0.0/24"
* public subnet 2 &rarr; "10.200.0.1/24"
* private subnet 1 &rarr; "10.200.0.2/24"
* private subnet 2 &rarr; "10.200.0.3/24"

Availability zones are automatically determined by region and then the first two are assigned to
the public and private subnets.

See the `variables.tf` file for further customizations.

## Tags
Tags are automatically added to all resources where possible. Tags will have the following format:

```
tags = {
    Name = "shared-${var.environment}-resource"
    Deployment_Method = "terraform"
    Environment = var.environment
  }
```