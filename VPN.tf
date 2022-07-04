# Create Customer Gateway and Attach it to VPC
resource "aws_customer_gateway" "ACG" {
  bgp_asn    = 65000
  ip_address = "172.83.124.10" //Public IP of the onprem network
  type       = "ipsec.1"

  tags = {
    Name = "main-customer-gateway"
  }
}

#Create Virtual private Gateway & attach to VPC
resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "UB_Virtaul_Private_Gateway"
  }
}
#Create VPN
resource "aws_vpn_connection" "UB_VPN" {
  vpn_gateway_id      = aws_vpn_gateway.vpn_gw.id
  customer_gateway_id = aws_customer_gateway.ACG.id
  type                = "ipsec.1"
  static_routes_only  = true
  
  tags = {
    Name = "UB_VPN"
  } 
}


//Saving the VPN configuration file on local disk
resource "local_file" "VPN-configuration-file" {
    content  = aws_vpn_connection.UB_VPN.customer_gateway_configuration
    filename = "UB_VPN.txt"
}