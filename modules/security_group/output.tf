# Output variable definitions

output "sg_public_id" {
  value       = aws_security_group.sg_public.id
  description = "Secutiry Group ID"
}

output "sg_private_id" {
  value       = aws_security_group.sg_private.id
  description = "Secutiry Group ID"
}