####------------------------####
##### Networking Resources #####
####------------------------####

# Grabs the availability zones for the current region.
data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# Virtual private cloud with custom cidr block.
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "shared-${var.environment}-vpc"
    Deployment_Method = "terraform"
    Environment = var.environment
  }
}

# Internet gateway attached to VPC.
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
   Name = "shared-${var.environment}-ig"
   Deployment_Method = "terraform"
   Environment = var.environment
  }
}

# Public subnet 1.
resource "aws_subnet" "public-1" {
 availability_zone = data.aws_availability_zones.available.names[0]
 vpc_id = aws_vpc.vpc.id
 cidr_block = var.public_subnet1_cidr_block

 tags = {
   Name = "shared-${var.environment}-public-1"
   Deployment_Method = "terraform"
   Environment = var.environment
 }
}

# Public subnet 2.
resource "aws_subnet" "public-2" {
  availability_zone = data.aws_availability_zones.available.names[1]
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet2_cidr_block

  tags = {
    Name = "shared-${var.environment}-public-2"
    Deployment_Method = "terraform"
    Environment = var.environment
  }
}


# Private subnet 1.
resource "aws_subnet" "private_1" {
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet1_cidr_block

  tags = {
    Name = "shared-${var.environment}-private-1"
    Deployment_Method = "terraform"
    Environment = var.environment
  }
}

# Private subnet 2.
resource "aws_subnet" "private_2" {
  availability_zone = data.aws_availability_zones.available.names[1]
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet2_cidr_block

  tags = {
    Name = "shared-${var.environment}-private-2"
    Deployment_Method = "terraform"
    Environment = var.environment
  }
}

# Nat gateway set up in public-subnet-1.
resource "aws_nat_gateway" "nat-gw" {
 allocation_id = aws_eip.nat.id
 subnet_id = aws_subnet.public-1.id

 tags = {
   Name = "shared-${var.environment}-nat-gw"
   Deployment_Method = "terraform"
   Environment = var.environment
 }
}
# Allocates an EIP to the nat gateway.
resource "aws_eip" "nat" {
 vpc = true
}

# Public route table.
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "shared-${var.environment}-public-rt"
    Deployment_Method = "terraform"
    Environment = var.environment
  }
}
# Private route table.
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
   Name = "shared-${var.environment}-private-rt"
   Deployment_Method = "terraform"
   Environment = var.environment
  }
}

# Public route table association between public-subnet-1 and the public route table.
resource "aws_route_table_association" "rta-public-1" {
 subnet_id = aws_subnet.public-1.id
 route_table_id = aws_route_table.public_route.id
}

# Public route table association between public-subnet-2 and the public route table.
resource "aws_route_table_association" "rta-public-2" {
 subnet_id = aws_subnet.public-2.id
 route_table_id = aws_route_table.public_route.id
}

# Private route table association between public-subnet-2 and the public route table.
resource "aws_route_table_association" "rta_private_1" {
 subnet_id = aws_subnet.private_1.id
 route_table_id = aws_route_table.private_route.id
}

# Private route table association between public-subnet-2 and the public route table.
resource "aws_route_table_association" "rta_private_2" {
 subnet_id = aws_subnet.private_2.id
 route_table_id = aws_route_table.private_route.id
}