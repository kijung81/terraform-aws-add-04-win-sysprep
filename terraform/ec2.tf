data "aws_vpc" "default" {
  id = var.vpc_id
}
data "aws_subnet" "default" {
  id = var.subnet_id
}

data "aws_ami" "window" {
  #most_recent = true

  filter {
    name   = "image_id"
    values = ["ami-0efa0ff5d179403bb"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099984158942"] # my accont id
}

resource "aws_instance" "win" {
  ami           = data.aws_ami.window.id
  instance_type = "t3.small"
  subnet_id     = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.win.id]
  associate_public_ip_address = true
  # key_name      = var.ec2_key
  tags = {
    Name = "${var.prefix}-windows"
  }
  user_data = templatefile("${path.module}/user_data.tftpl", { 
    admin_password = var.admin_password,
    host_name = var.host_name,
    ad_dns = var.ad_dns,
    domain = var.domain,
    ad_username = var.ad_username,
    ad_password = var.ad_password
  })
}

resource "aws_instance" "win2" {
  ami           = data.aws_ami.window.id
  instance_type = "t3.small"
  subnet_id     = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.win.id]
  associate_public_ip_address = true
  # key_name      = var.ec2_key
  tags = {
    Name = "${var.prefix}-windows"
  }
  user_data = templatefile("${path.module}/user_data.tftpl", { 
    admin_password = var.admin_password,
    host_name = var.host_name2,
    ad_dns = var.ad_dns,
    domain = var.domain,
    ad_username = var.ad_username,
    ad_password = var.ad_password
  })
}