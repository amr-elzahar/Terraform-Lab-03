data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.ubuntu.image_id
  instance_type               = var.type
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.private_sg]
  subnet_id                   = var.subnet_id
  key_name                    = "Test"

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.public_ip
    private_key = file("./Test.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo su",
      "apt update -y",
      "apt install apache2 -y",
      "systemctl enable apache2",
      "systemctl start",
    ]
  }

  provisioner "local-exec" {
    command = "echo Private IP address is: ${self.private_ip} >> priv-ips.txt"
  }

  tags = {
    "Name" = "Private EC2"
  }
}