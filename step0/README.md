# tfstateをS3に保存する

tfstateはローカルに保存しているとチームで開発する際に新しいリソースを作成したりしてしまうから、リモートバックエンドで管理する。　　
S3のリソースを定義する

``` 
# S3バケット 
resource "aws_s3_bucket" "remote_backend" {
  bucket = "terraform-s3-nakamura"  # 被らない名前をつける
lifecycle {                         # ライフサイクル
  prevent_destroy = true            # terraformでバケットを削除できないようにする設定 削除したい場合 false
 }

 tags = {
   Name = "remote_backend_s3"
   Environment = "dev"
 }

}
# バージョニング有効化
resource  "aws_s3_bucket_versioning" "remote_backend" {
  bucket = "aws_s3_bucket.remote_backend.id"  # remote_backend.idでどのバケットのバージョニングを有効にするのか識別してる
  versioning_configuration {
    status = "Enabled"
  }

}


```



### terraformのバージョンとプロバイダを設定する

``` 
terraform {
  required_version = ">= 1.0.0"

  required_providers {   
    aws = {
      version = "> 4.49.0"
    }
  }
}
provider "aws" {
  region = "ap-northeast-1"

}

```
- `required_providers`  使用するプロバイダとバージョンを指定する 
- `provider "aws"`リージョンを指定する


terraformはディレクトリ下の.tfファイルを全て読み込むため、別のディレクトリのtfstateファイルも同じバケットに保存したいならS3の情報をoutput別ディレクトリに参照させないといけないかもしれない

main.tfで　S3が作成できたらS3をリモートバックエンドとして設定するコードをversions.tfに追加する

```
terraform {
  # 追加
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

```

## backendブロック内容

- `bucket "3"` tfstateを管理するバックエンドとしてAWS S3を選択する  
- `bucket`  tfstateを保存するS3bucket名を選択する  
- `key`  保存先のパス　現在はバケットのterraform-s3-nakamuraディレクトリ直下にほぞんする  
- `region`  S3バケットが配置されているリージョンを選択する


### リモートバックエンドの設定を反映する
以下のコマンドを実行する
```
terraform init -migrate-state
```
このコマンドでterraformがローカルのtf.stateをS3にコピーして、S3をリモートバックエンドに設定します
