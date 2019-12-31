provider "aws" {
  region = "eu-central-1"
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "bastion-sg" {
  name   = "bastion-security-group"
  vpc_id = "${aws_default_vpc.default.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  ami                         = "ami-0cc0a36f626a4fdf5"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "aws_bastion.pub"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDAnf/n3nU70tmeBfs6XQf3UREW80cBWtQjjMLu/b73qLHeNZlif+0wZkRq1dJxNSir4DgQ8q0Yggc/1101Dgeva8fYdxyt0I11A6LeHu0U0hRHrhUXfbMOmmRyA4cvV4jf1qoQRy/sHbnxMDmiL5kosoUKhFj3VB+oQLRkhi0rFrlVsDOMNPj3Amgm2o4uosAqaJcdFs+4SnbOZ31TzvrPrVwsE8maVNCsBaszMgdpX4Mf18d/FWN4+89REDj0c4i+00Gh/bXWwMgGWKrFNovFJHp/blhtbpT0MkAnbTibsGlAd05p3lZOuNtXajxj0voDVepxFyCMwlM10pA0EEi+Qp/ApT8CIlqRStHEp/WTh8F4uVsRk9WW41z6597wxJlMUrHNSJBPhI8IEcKaI9L/ivgtDclxQ1VgC3cyw2vJeF302NpT+AEVaOdVktL9jUzCPNSin6SBLygalZ3sZQjDVYoqAXBloDjAeW9nzBAaj2b/Ha+xMa6sw+mgDqD48mVzIDKZn3R5Ce4Q3LvZ2ex3oP8ijlJYLvD97a56yDaerRtGqX0NZVe1J3D7brDxwocBTu+4ErM1EbzpSRR79p9HpzqLqxM3F/IZsQ+URlTv3JnFHuboRG6lCW3oO2pDcxpLQ76mc05xgNmI4Au41JsdZJk0hVm1FOygZ9Hg/dV7YQ== i.batyrov@gmail.com"
}


output "bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}