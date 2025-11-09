# README

## Illuminati Infrastructure – Stage Environment

This project provisions shared CI/CD infrastructure for the Illuminati platform using Terraform and Terragrunt.
It sets up core services required for automation and continuous delivery within the stage environment.

### Purpose

The configuration creates and manages key CI/CD and shared services components on AWS:

- Jenkins -orchestrates automated deployments across environments.

- SonarQube – provides code quality and security analysis for all projects.

- ECR – hosts Docker images for application services.

- Cross-account IAM roles – allow Jenkins to deploy workloads securely into other AWS environments.

This infrastructure acts as the foundation of the deployment pipeline, enabling Jenkins to automate builds, scans, and environment provisioning.

### Usage

#### Initialize Terragrunt

```
terragrunt init
```

#### Validate configuration
```
terragrunt validate
```

#### Plan changes

```
terragrunt plan
```

#### Apply deployment
```
terragrunt apply
```

Use stage/manual for initial Jenkins and IAM role setup, and stage/automated for SonarQube and ECR managed by Jenkins afterward.

