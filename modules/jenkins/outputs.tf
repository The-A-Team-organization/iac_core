output "subnet_id" {
  description = "The ID of the subnet created for the Jenkins instance"
  value       = aws_subnet.jenkins_subnet.id
}

output "security_group_id" {
  description = "The ID of the security group assigned to the Jenkins instance, defining allowed inbound and outbound traffic"
  value       = aws_security_group.jenkins_sg.id
}

output "instance_id" {
  description = "The ID of the Jenkins EC2 instance"
  value       = aws_instance.jenkins.id
}

output "public_ip" {
  description = "The public IP address associated with the Jenkins EC2 instance, used for external access"
  value       = aws_eip.jenkins_eip.public_ip
}

output "jenkins_role_arn" {
  description = "ARN of the Jenkins IAM role (to be used in cross-account trusts)"
  value       = aws_iam_role.jenkins_role.arn
}
