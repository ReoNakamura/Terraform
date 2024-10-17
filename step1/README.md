# vpcだけ作るテスト.tf

tf.stateはsetp0ディレクトリで作成したS3のkeyだけ変えて保存されるかやってみたらちゃんとS3に保存された。

### やり方

step0とあまり変わらないが自分用にの残す。


step1の場合はtest.tfにプロバイダとバージョンをかているので、versions,tfにはS3のbackendの情報だけ書く。

```
# versons.tf

terraform {
backend "s3" {
  bucket         = "terraform-s3-nakamura"
  key            = "terraform-s3-nakamura/step1/terraform.tfstate"
  region         = "ap-northeast-1"
  }


}

```

これも忘れずに
```
terraform init -migrate-state 

```
これでapplyするとtf.stateがS3に保存された
