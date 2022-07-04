# Create Security Group for the Bastion Host aka Jump Box
# terraform aws create security group
resource "aws_security_group" "RDP-security-group" {
  name        = "Allow RDP"
  description = "Enable RDP access on Port 3389"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "RDP Access"
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["${var.RDP-location}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "RDP Security Group"
  }
}


/*
# Create Security Group for the Web Server
# terraform aws create security group
resource "aws_security_group" "webserver-security-group" {
  name        = "Web Server Security Group"
  description = "Enable HTTP/HTTPS access on Port 80/443 via ALB and SSH access on Port 22 via SSH SG"
  vpc_id      = aws_vpc.vpc.id


  ingress {
    description      = "SSH Access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.RDP-security-group.id}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "Web Server Security Group"
  }
}
*/

