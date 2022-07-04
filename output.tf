output "ssh_keypair" {
  value = tls_private_key.key.private_key_pem
  sensitive = true
}


output "key_name" {
  value = aws_key_pair.key_pair.key_name

}

output "public_ip" {
  value = aws_instance.ec2_public.public_ip
}
/*
output "private_ip" {
  value = aws_instance.ec2_private.private_ip
}
*/

output "gateway_configuration" {
description = "Gateway configuration"
value = aws_vpn_connection.UB_VPN.customer_gateway_configuration
sensitive = true
}