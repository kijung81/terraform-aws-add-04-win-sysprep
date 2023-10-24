packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.6"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami_prefix" {
  type    = string
  default = "Golfzon-PoC-packer-win-aws-init"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "sysprep-windows" {
  ami_name      = "${var.ami_prefix}-focal-${local.timestamp}"
  communicator  = "winrm"
  instance_type = "t3.medium"
  region        = "ap-northeast-2"

  source_ami_filter {
    filters = {
      name                = "Windows_Server-2019-English-Full-Base*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["801119661308"]
  }

  winrm_password = "firstpassword1!"
  winrm_username = "Administrator"
  user_data_file = "./bootstrap_win.txt"
}


build {
  name    = "learn-packer"
  sources = ["source.amazon-ebs.sysprep-windows"]

  provisioner "powershell" {
    debug_mode=1
    script = "./win_all.ps1"
  }
}
