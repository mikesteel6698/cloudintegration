output "private_ip_pro_1" {
  value = aws_instance.pro_1.private_ip
}

output "public_ip_pro_1" {
  value = aws_instance.pro_1.public_ip
}