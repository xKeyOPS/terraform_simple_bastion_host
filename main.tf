provider "aws" {
  region = "eu-central-1"
}

resource "aws_default_vpc" "default" {}

resource "aws_instance" "bastion" {
  ami                         = "ami-969ab1f6"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
}

output "bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}