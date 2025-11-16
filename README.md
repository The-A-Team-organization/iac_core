# README

## Illuminati Infrastructure – Stage Environment

This repository contains Terraform modules for provisioning shared CI/CD infrastructure in the Illuminati platform.
It serves as a building block for the stage environment and is consumed by Terragrunt, which orchestrates deployments across environments.

### Purpose

This repository provides Terraform modules that define the core CI/CD components on AWS:

- Jenkins - orchestrates automated builds, tests, and deployments.

- SonarQube – provides code quality and security scans.

- ECR – stores Docker images for platform services.

- Cross-account IAM roles – allow Jenkins to deploy workloads securely into other AWS environments.

These modules are not meant to be applied directly via terraform apply. Instead, they are referenced by Terragrunt configurations in higher-level environment repos.

### Structure

- main.tf – integrates individual modules into a complete stage stack definition

- modules/ – reusable Terraform modules:
  - jenkins/

  - sonarqube/

  - ecr/

  - cross_account/

- templates/ – user data templates for EC2 instances

### Usage

If you want to test a module in isolation:

```
terraform init
terraform plan
```

However, in normal workflow, these modules are consumed by Terragrunt from a higher-level repository [iac_terragrunt](https://github.com/The-A-Team-organization/iac-terragrunt).
