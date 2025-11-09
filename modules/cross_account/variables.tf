variable "env" {
  description = "Target environment name"
  type        = string
}

variable "jenkins_role_arn" {
  description = "ARN of the Jenkins role in Stage account which will be trusted"
  type        = string
}

variable "role_name" {
  description = "Name prefix for created role in target account (module instance will append env)"
  type        = string
  default     = "ci-deploy-role"
}
