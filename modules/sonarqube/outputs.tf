output "subnet_id" {
  description = "The ID of the subnet created for the SonarQube instance"
  value       = aws_subnet.sonarqube_subnet.id
}

output "security_group_id" {
  description = "The ID of the security group assigned to the SonarQube instance, defining inbound and outbound traffic rules"
  value       = aws_security_group.sonarqube_sg.id
}

output "instance_id" {
  description = "The ID of the SonarQube EC2 instance"
  value       = aws_instance.sonarqube.id
}

output "public_ip" {
  description = "The public IP address associated with the SonarQube EC2 instance, used for external access"
  value       = aws_eip.sonarqube_eip.public_ip
}

