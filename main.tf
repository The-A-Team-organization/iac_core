module "jenkins" {
  source = "./modules/jenkins"

  region            = var.region
  vpc_id            = var.vpc_id
  igw_id            = var.igw_id
  availability_zone = var.availability_zone
  common_tags       = var.common_tags
  env               = "stage"
  ami               = var.jenkins.ami
  instance_type     = var.jenkins.instance_type
  subnet_cidr       = var.jenkins.subnet_cidr
  user_data         = templatefile("${path.module}/templates/user_data.tftpl", {})
}

module "sonarqube" {
  source = "./modules/sonarqube"

  region            = var.region
  vpc_id            = var.vpc_id
  igw_id            = var.igw_id
  availability_zone = var.availability_zone
  common_tags       = var.common_tags
  env               = "stage"
  ami               = var.sonarqube.ami
  instance_type     = var.sonarqube.instance_type
  subnet_cidr       = var.sonarqube.subnet_cidr
}

module "ecr" {
  source       = "./modules/ecr"
  env          = "stage"
  common_tags  = var.common_tags
  repositories = var.ecr_repositories
}

module "cross_account_dev" {
  source = "./modules/cross_account"

  providers = {
    aws = aws.dev
  }

  env              = "dev"
  role_name        = "ci-deploy-role"
  jenkins_role_arn = module.jenkins.jenkins_role_arn
}

module "cross_account_prod" {
  source = "./modules/cross_account"

  providers = {
    aws = aws.prod
  }

  env              = "prod"
  role_name        = "ci-deploy-role"
  jenkins_role_arn = module.jenkins.jenkins_role_arn
}
