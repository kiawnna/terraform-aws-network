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
Reference outputs like:
module.vpc.vpc_id

## Variables / Customization
Cidr blocks can be customized. Defaults are:

Availability zones are automatically determined by region and then the first two are assigned to
the public and private subnets.

See the variables.tf file for further customizations.

