# Terraform
Terraformの基礎学習をまとめる

[参考サイト](https://fintan.jp/page/7192/)
これを見ながら実際にやってみた
## terraform CLIのinstall

``` bash
# MacOSはこのコマンドでインストールする
$ brew tap hashicorp/tap
$ brew install hashicorp/tap/terraform

```

[こちらの公式サイトを参照](https://developer.hashicorp.com/terraform/install)

インストールできたら以下でコマンドが使用できるか確認します。

``` zsh
$ terraform version

```
バージョンが表示されれば完了

## AWS CLIもインストールされている必要がある
MacOSは以下のコマンド

``` bash
$ curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2 pkg"
$ sudo installer -pkg AWSCLIV2.pkg -target /

# インストール済みかこれで確認
$ aws --version

# 以下のコマンドでCLI接続確認ができる　アクセスキーやシークレットアクセスキーが要求されるので入力する
$ aws configure
```
[AWS公式ドキュメント](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## Terraformの基本コマンド
``` 
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure

```


## terraform init
moduleの追加する時などのプラグインをインストールする時にに使うコマンド

## terraform plan
リソースの追加・更新・削除の実行計画計画の確認をするコマンド,実際にのリソースには反映されない

## terraform apply
planの実行で問題がなければ、applyで実際にリソースの追加・更新・削除が実行できる
## terraform destroy
インフラリソースの削除ができるコマンド。使用するときはよく確認して最大限注意を払う
## terraform fmt
コードのフォーマットを統一する。=の位置が揃うなど 次のコマンドで .tfを持つファイル全てにフォーマットをかけて統一する事ができる
``` 
$ terraform fmt -recursive

```
## terraform validate
構文エラーをチェックしてくれる

