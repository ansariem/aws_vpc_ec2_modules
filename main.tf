provider "aws" {
  #region = "us-east-1"
  region = "${module.first_lab_vpc.var.region}"
}

#module first lab VPC. we can use it for one more vpc if required, only we have to modify the values from the module ony.
module "first_lab_vpc" {
  source             = "./vpc"
  region             = "us-east-1"
  vpc_cidr           = "10.0.0.0/16"
  public_cidrs       = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_cidrs      = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  vpc_tag            = "first_lab"
  igw_tag            = "first_lab_igw"
  public_subnet_tag  =  "first_lab_public_subnet"
  private_subnet_tag =  "first_lab_private_subnet"
}
# My second VPC LAB module
module "second_lab_vpc" {
  source             = "./vpc"
  region             = "us-east-1"
  vpc_cidr           = "192.168.0.0/16"
  public_cidrs       = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  private_cidrs      = ["192.168.4.0/24", "192.168.5.0/24", "192.168.6.0/24"]
  vpc_tag            = "second_lab"
  igw_tag            = "second_lab_igw"
  public_subnet_tag  =  "second_lab_public_subnet"
  private_subnet_tag =  "second_lab_private_subnet"
}

# My first EC2 LAB

module "first_ec2_lab" {
  source            = "./ec2"
  region            = "us-east-1"
  my_key_name       = "ansarivirginiakey"
  instance_type     = "t2.micro"
  security_group    = "${module.first_lab_vpc.security_group_vpc}"
  subnet            = "${module.first_lab_vpc.subnets}"
  iam_profile       = "day7ssm"
  ami               = "ami-04ebc3e86c4d05d87"
  ec2_tag           = "web-lab"
  ec2_count         = "2"
  }

# My second EC2 LAB

module "second_ec2_lab" {
  source            = "./ec2"
  region            = "us-east-1"
  my_key_name       = "ansarivirginiakey"
  instance_type     = "t2.micro"
  security_group    = "${module.second_lab_vpc.security_group_vpc}"
  subnet            = "${module.second_lab_vpc.subnets}"
  iam_profile       = "day7ssm"
  ami               = "ami-0015b9ef68c77328d" 
  ec2_tag           = "db-lab"
  ec2_count         = "3"
  
}
