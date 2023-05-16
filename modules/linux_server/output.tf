# Output variable definitions

output "linux_server" {
  value       = aws_instance.linux_server
  description = "Linux EC2 instance"
}