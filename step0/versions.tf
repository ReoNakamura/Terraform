# versons.tf  このファイルにプロバイダやtfstateの保存先をS3に変えるなどができる
terraform {
  backend "s3" {
  bucket         = "terraform-s3-nakamura"
  key            = "terraform-s3-nakamura/terraform.tfstate"
  region         = "ap-northeast-1"
  }

  required_providers {
    aws = {
      version = "> 4.49.0"
    }
  }
}
provider "aws" {
  region = "ap-northeast-1"

}



