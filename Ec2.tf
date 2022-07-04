
#Create a new EC2 launch configuration
resource "aws_instance" "ec2_public" {
  ami                    = "ami-014c4bcfe3cae98f0"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.RDP-security-group.id}"]
  subnet_id                   = "${aws_subnet.public-subnet-1.id}"
  #associate_public_ip_address = true
  #disable_api_termination = "true" //Enable termination protection
  #user_data                   = "${data.template_file.provision.rendered}"
  #iam_instance_profile = "${aws_iam_instance_profile.some_profile.id}"
  # root disk
  root_block_device {
    volume_size           = "100"
    volume_type           = "gp2"
    encrypted             = true
    kms_key_id            = aws_kms_key.my-kms-key.id
    delete_on_termination = true
  }
  # data disk
  ebs_block_device {
    device_name           = "xvdf"
    volume_size           = "200"
    volume_type           = "gp2"
    encrypted             = true
    kms_key_id            = aws_kms_key.my-kms-key.id
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = true
  }
   tags = {
    "Name" = "EC2-PUBLIC"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.ec2_public.id
  vpc      = true
}

  
  /*
  # Copies the ssh key file to home dir
   # Copies the ssh key file to home dir
  provisioner "file" {
    source      = "./${var.key_name}.pem"
    destination = "/home/ec2-user/${var.key_name}.pem"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }
  }
  
  //chmod key 400 on EC2 instance
  provisioner "remote-exec" {
    inline = ["chmod 400 ~/${var.key_name}.pem"]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }

  }
}
*/
/*
#Create a new EC2 launch configuration
resource "aws_instance" "ec2_private" {
  #name_prefix                 = "terraform-example-web-instance"
  ami                    = "ami-0eb7496c2e0403237"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.webserver-security-group.id}"]
  subnet_id                   = "${aws_subnet.private-subnet-1.id}"
  associate_public_ip_address = false
  #user_data                   = "${data.template_file.provision.rendered}"
  #iam_instance_profile = "${aws_iam_instance_profile.some_profile.id}"

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "EC2-Private"
  }
} 

*/
