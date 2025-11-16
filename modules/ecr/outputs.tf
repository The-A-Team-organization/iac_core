output "repository_uris" {
  description = "A map containing the URIs of all created ECR repositories, used to store and retrieve Docker images for different services"
  value       = local.repo_map
}
