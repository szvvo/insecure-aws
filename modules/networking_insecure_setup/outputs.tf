# /modules/networking_insecure_setup/outputs.tf

output "vpc_id" {
  description = "The ID of the insecure VPC."
  value       = aws_vpc.insecure_vpc.id
}

output "public_subnet_ids" {
  description = "A list of the public subnet IDs."
  value       = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
}

output "insecure_security_group_id" {
  description = "The ID of the wide-open security group."
  value       = aws_security_group.wide_open_sg.id
}