variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "repositories" {
  description = "List of ECR repositories to create"
  type        = list(string)
}

variable "common_tags" {
  type = map(string)
  default = {
    "CreatedBy"   = "Terraform"
    "Project"     = "Illuminati"
    "Environment" = "stage"
    "Repository"  = "https://github.com/The-A-Team-organization/iac_core"
    "Module"      = "environment_setup"
  }
}

