terraform {
backend "s3" {
  bucket         = "terraform-s3-nakamura"
  key            = "terraform-s3-nakamura/step1/terraform.tfstate"
  region         = "ap-northeast-1"
  }


}
