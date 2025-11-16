output "jenkins_public_ip" {
  value       = module.jenkins.public_ip
  description = "Public IP allocated to Jenkins"
}

output "jenkins_subnet_id" {
  value = module.jenkins.subnet_id
}

output "sonarqube_public_ip" {
  value = module.sonarqube.public_ip
}

output "sonarqube_subnet_id" {
  value = module.sonarqube.subnet_id
}

output "ecr_repository_uris" {
  value = module.ecr.repository_uris
  description = "Map repo_name, repository_url"
}

