

variable "vpc_id" {
  default = "vpc-0fee7902760f76f62"
}

variable "subnet_id" {
  default = "subnet-064b08e56ca5fbc3b"
}

variable prefix {
  default = "TF-PoC-07-win"
}

variable ec2_key{
  default = "Terraform-PoV"
}

variable host_name {
  # default = "tf-poc-winhost"
  default = "tf-poc-winhost3"  
}

variable admin_password {
  default = "golfzonaws1!"
}

variable ad_dns {
 default = "10.10.7.201"
}

variable domain {
  default = "gzpoc.corp"
}

variable ad_username {
  # default = "gzpoc.corp\\connector2"
  default = "gzpoc.corp\\connector3"  
}

variable ad_password {
  default = "golfzon12!@"
}