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

# git　pushでエラーが起きた

terraformで環境構築すると.terraform/providers/**とファイルが作成されて、このファイルが大きすぎてgitのpushのファイルサイズ100mbの上限を超過してしエラーが起きた。

# 解決するために


## 結論

 .gitignoreで特定のfileを除外すると解決した



## まずしたこと

### 1. Git lfs のインストール

これで100mbの上限をあげる事ができる。
macなのでhomebrewでインストールできる

``` bash
brew install git-lfs
```
コミット履歴が残っているとpushしてもエラーになるのでコミットを取り消す

``` bash
$ cd {REPO} # リポジトリに移動
$ git reset --soft 'HEAD^'  クォートで挟まないと実行できない
```

### 2. 再びコミットする

Git lfsを使ったコミットをする

``` bash
$ git lfs track (大きいファイル)           # {大きいファイル} を登録
Tracking {大きいファイル}
$ git add .gitattributes # 登録したファイルをadd


```
こうするとファイルが作られて中に登録した大きいファイルが書かれている。  
一度登録すればあとは普段通りにコミットすればよい  
これでpushしたけど同じエラーで解決せず、別の方法を探した。

## .gitignoreを使ってgitで管理したくないfileを登録しておく

リポジトリに.gitignoreファイルを作成して

```
# Terraform関連の不要なファイル・ディレクトリを除外

# 格階層の.terraformのディレクトリごと除外する 
**/.terraform/

# ローカルの .tfstate ファイルを無視する
*.tfstate
*.tfstate.*
*.tfstate.backup


```
このように書く事で対象のファイルをgitに上げずローカルで管理できるようになる。  
これでpushすると無事gitに上げる事ができた。

### .gitignoreについて

これまで存在も知らなかったけど開発でリモートとローカルどちらで管理するかファイルによって異なるため、メリット、デメリットを理解して判断する。
今回の.terraform内のファイルはgitで管理する必要が無いみたいなので除外した。


