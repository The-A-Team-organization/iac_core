variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where Jenkins will be deployed"
  type        = string
}

variable "igw_id" {
  description = "The ID of the Internet Gateway associated with the VPC. If provided, it enables internet access for the SonarQube subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for subnets"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "ami" {
  description = "Machine Image that provides the software necessary to configure and launch an EC2 instance"
  type        = string
}


variable "instance_type" {
  description = "The instance type for the Jenkins EC2 instance"
  type        = string
}


variable "common_tags" {
  type = map(string)
  default = {
    "CreatedBy"   = "Terraform"
    "Project"     = "Illuminati"
    "Environment" = "stage"
    "Repository"  = "https://github.com/The-A-Team-organization/iac_core"
    "Module"      = "jenkins"
  }
}


variable "subnet_cidr" {
  description = "The CIDR block defining the IP address range for the SonarQube subnet"
  type        = string
}
