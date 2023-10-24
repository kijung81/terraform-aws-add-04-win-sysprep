terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # cloud {
  #   organization = "Golfzon"
  #   workspaces {
  #     name = "Add_scenario_07_win"
  #   }
  # }  
}

provider "aws" {
  region = "ap-northeast-2"
}