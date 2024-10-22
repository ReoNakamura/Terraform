terraform {
  required_providers {
    aws = {

      version = "> 4.49.0"
    }
  }

  backend "s3" {
    bucket = "terraform-s3-nakamura"
    key    = "terraform-s3-nakamura/step2/terraform.tfstate"
    region = "ap-northeast-1"
  }

}

provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      Env   = "terraform-practice"
      Owner = "nakamura"
    }
  }
}
