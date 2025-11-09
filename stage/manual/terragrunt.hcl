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
  vpc_id            = "dependency.network.outputs.vpc_id"
  igw_id            = "dependency.network.outputs.igw_id"
  availability_zone = "eu-central-1a"

  common_tags = local.common_tags

  jenkins = {
    ami               = "ami-0a5b0d219e493191b"
    instance_type     = "c7i-flex.large"
    subnet_cidr       = "10.0.10.0/24"
  }

}

extra_arguments "targets_manual_phase" {
  commands = ["apply", "plan", "destroy"]
  arguments = [
    "-target=module.jenkins",
    "-target=module.cross_account_dev",
    "-target=module.cross_account_prod"
  ]
}

