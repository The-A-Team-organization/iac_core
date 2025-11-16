variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_id" {
  description = "Existing VPC id to use"
  type        = string
}

variable "igw_id" {
  description = "Optional Internet Gateway id in the VPC. If provided, modules will create a default 0.0.0.0/0 route in their route table. Leave empty to skip that route."
  type        = string
  default     = ""
}

variable "availability_zone" {
  description = "AZ to place stage subnets/instances"
  type        = string
  default     = ""
}

variable "common_tags" {
  type = map(string)
  default = {
    CreatedBy   = "Terraform"
    Project     = "Illuminati"
    Environment = "stage"
    Repository  = "https://github.com/The-A-Team-organization/illuminati_iac"
    Module      = "stage_setup"
  }
}

variable "jenkins" {
  type = object({
    ami           = string
    instance_type = string
    subnet_cidr   = string
  })
}

variable "sonarqube" {
  type = object({
    ami           = string
    instance_type = string
    subnet_cidr   = string
  })
}

variable "ecr_repositories" {
  description = "List of repository names"
  type        = list(string)
  default     = ["frontend", "backend", "mailer_service", "scheduler_service"]
}

