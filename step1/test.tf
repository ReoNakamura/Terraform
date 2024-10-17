terraform {
  
  required_providers {   #プロバイダを別ファイルに分けずにリソースファイルに直接指定しているこの状態でversions.tfでプロバイダをしていしても重複エラーになる
    aws = {
      version = "> 4.49.0"
    }
  }
}
provider "aws" {
  region = "ap-northeast-1"
}


resource "aws_vpc" "tf_test" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "tf-test"
  }
}
