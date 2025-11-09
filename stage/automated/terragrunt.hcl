include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_terragrunt_dir()}/.."
}

dependency "network" {
  config_path = ""
}

inputs = {
  region            = local.region
  vpc_id            = ""
  igw_id            = ""
  availability_zone = "eu-central-1a"

  common_tags = local.common_tags

  sonarqube = {
    ami               = "ami-0a5b0d219e493191b"
    instance_type     = "c7i-flex.large"
    subnet_cidr   = "10.0.21.0/24"
  }

  ecr_repositories = ["frontend", "backend", "mailer_service", "scheduler_service"]
}

extra_arguments "targets_automated_phase" {
  commands = ["apply", "plan", "destroy"]
  arguments = [
    "-target=module.sonarqube",
    "-target=module.ecr"
  ]
}

