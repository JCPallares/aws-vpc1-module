# Output variable definitions

output "bastion_server" {
  value       = aws_instance.bastion_server
  description = "Bastion Server EC2 instance"
}