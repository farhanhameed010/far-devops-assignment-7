# Outputs (corrected - removed duplicates)
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "instance_private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.web.private_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "ubuntu_ami_id" {
  description = "ID of the Ubuntu AMI being used"
  value       = data.aws_ami.ubuntu_22_04.id
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i /path/to/private_key.pem ubuntu@${aws_instance.web.public_ip}"
}