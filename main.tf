// AWS CREDENTIALS
provider "aws" {
  secret_key = ""
  access_key = ""
  region     = ""
}

// REMOTE STATE
terraform {
  backend "s3" {
    bucket = "terraform-state-lab3"
    key    = "terraform-state-file"
    region = "us-east-2"
  }
}

// CREATE VPC
module "vpc" {
  source     = "./vpc"
  cidr_block = "10.0.0.0/16"
  tag        = "Demo VPC"
}


// CREATE PUBLIC SUBNETS
module "public-subnet-1" {
  source     = "./subnet"
  cidr_block = "10.0.0.0/24"
  vpc_id     = module.vpc.vpc_id
  az         = "us-east-2a"
  tag        = "Public Subnet 1"
}

module "public-subnet-2" {
  source     = "./subnet"
  cidr_block = "10.0.2.0/24"
  vpc_id     = module.vpc.vpc_id
  az         = "us-east-2b"
  tag        = "Public Subnet 2"
}

// CREATE PRIVATE SUBNETS
module "private-subnet-1" {
  source     = "./subnet"
  cidr_block = "10.0.1.0/24"
  vpc_id     = module.vpc.vpc_id
  az         = "us-east-2a"
  tag        = "Private Subnet 1"
}

module "private-subnet-2" {
  source     = "./subnet"
  cidr_block = "10.0.3.0/24"
  vpc_id     = module.vpc.vpc_id
  az         = "us-east-2b"
  tag        = "Private Subnet 2"
}

// CREATE IGW
module "internet-gateway" {
  source = "./igw"
  vpc_id = module.vpc.vpc_id
  tag    = "Internet Gateway"
}

// CREATE PUBLIC ROUTE TABLE
module "public-route-table" {
  source      = "./pub-rtb"
  vpc_id      = module.vpc.vpc_id
  subnet-1_id = module.public-subnet-1.subnet_id
  subnet-2_id = module.public-subnet-2.subnet_id
  igw_id      = module.internet-gateway.igw-id
  tag         = "Public Route Table"
}


// CREATE ELASTIC IPs
module "eip-1" {
  source = "./eip"
  tag    = "Elastic IP 1"
}

module "eip-2" {
  source = "./eip"
  tag    = "Elastic IP 2"
}

// CREATE NAT GATEWAYS
module "nat-1" {
  source    = "./ntgw"
  subnet_id = module.public-subnet-1.subnet_id
  eip_id    = module.eip-1.eip_id
  tag       = "NAT Gateway 1"
}

module "nat-2" {
  source    = "./ntgw"
  subnet_id = module.public-subnet-2.subnet_id
  eip_id    = module.eip-2.eip_id
  tag       = "NAT Gateway 2"
}

// CREATE PRIVATE ROUTE TABLES
module "private-route-table-1" {
  source    = "./priv-rtb"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.private-subnet-1.subnet_id
  ntgw_id   = module.nat-1.nat_id
  tag       = "Priavte Route Table 1"
}

module "private-route-table-2" {
  source    = "./priv-rtb"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.private-subnet-2.subnet_id
  ntgw_id   = module.nat-2.nat_id
  tag       = "Priavte Route Table 2"
}

// CREATE PUBLIC SECURITY GROUP
module "public-sg" {
  source = "./pub-sg-ec2"
  vpc_id = module.vpc.vpc_id
}

// CREATE PUBLIC EC2s
module "public-ec2-1" {
  source    = "./public-ec2s"
  type      = "t2.micro"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.public-subnet-1.subnet_id
  public_sg = module.public-sg.public_sg_id
}

module "public-ec2-2" {
  source    = "./public-ec2s"
  type      = "t2.micro"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.public-subnet-2.subnet_id
  public_sg = module.public-sg.public_sg_id
}


// CREATE PRIVATE SECURITY GROUP
module "private-sg" {
  source = "./prv-sg-ec2"
  vpc_id = module.vpc.vpc_id
}

// CREATE PRIVATE EC2s
module "private-ec2-1" {
  source     = "./private-ec2s"
  type       = "t2.micro"
  vpc_id     = module.vpc.vpc_id
  subnet_id  = module.private-subnet-1.subnet_id
  private_sg = module.private-sg.public_sg_id
}

module "private-ec2-2" {
  source     = "./private-ec2s"
  type       = "t2.micro"
  vpc_id     = module.vpc.vpc_id
  subnet_id  = module.private-subnet-2.subnet_id
  private_sg = module.private-sg.public_sg_id
}


// CREATE LOAD BALANCER SECURITY GROUP
module "load-balancer-sg" {
  source = "./lb-sec-grp"
  vpc_id = module.vpc.vpc_id
  tag    = "Load Balancer Security Group"
}

// CREATE PUBLIC LOAD BALANCER
module "public-lb" {
  source      = "./lb"
  lb-name     = "Public"
  lb_type     = "application"
  scheme      = false
  lb_sg_id    = module.load-balancer-sg.lb_sg_id
  subnet-1_id = module.public-subnet-1.subnet_id
  subnet-2_id = module.public-subnet-2.subnet_id
  tg-name     = "Public"
  vpc_id      = module.vpc.vpc_id
  ec2-1_id    = module.public-ec2-1.ec2_id
  ec2-2_id    = module.public-ec2-2.ec2_id
}

// CREATE PRIVATE LOAD BALANACER
module "private-lb" {
  source      = "./lb"
  lb-name     = "Private"
  lb_type     = "application"
  scheme      = true
  lb_sg_id    = module.load-balancer-sg.lb_sg_id
  subnet-1_id = module.private-subnet-1.subnet_id
  subnet-2_id = module.private-subnet-2.subnet_id
  tg-name     = "Private"
  vpc_id      = module.vpc.vpc_id
  ec2-1_id    = module.private-ec2-1.ec2_id
  ec2-2_id    = module.private-ec2-2.ec2_id
}



