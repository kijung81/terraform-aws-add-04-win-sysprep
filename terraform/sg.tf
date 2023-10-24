resource "aws_security_group" "win" {
  name        = "winsg"
  description = "ec2 win sg"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "winrm"
    from_port        = 5985
    to_port          = 5986
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }  

  ingress {
    description      = "rdp access"
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-win-sg"
  }
}