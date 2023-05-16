data "aws_ami" "linux_ami" {
  most_recent = true
  owners      = ["099720109477"] # This is the Canonical user ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "linux_server" {
  ami           = data.aws_ami.linux_ami.id
  instance_type = var.instance_type_ec2
  key_name      = var.ssh_key_name

  #user_data = file("./modules/linux_server/user_data.sh")

  vpc_security_group_ids = ["${var.security_group_id}"]
  subnet_id              = var.subnet_id

  associate_public_ip_address = false

  tags = {
    Name        = "linux_server"
    Environment = "datacenter"
  }
}