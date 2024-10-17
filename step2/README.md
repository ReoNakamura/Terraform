## variablesで変数にする

値を変数にして外だしするためにvaliablesブロックをつかう。これはどこにでも書けるが、variablesファイルにまとめた方が分かりやすい  
変数化させたい値ごとにvaliablesブロックごとに宣言する。ブロックで宣言した変数を使うにはリソース内で`ver.名前`でと指定すれば参照できる。  
文字列に中に入れたい場合は`${var.名前}`と書くと文字列の中に入れれる descriptionで値の説明を書いた方が良い  

``` 
# variables.tf

variable "subnet_cidr" {
  type = string
  description = "subnet_cidrの変数名です"
}

```

ブロックで宣言した変数に値を設定するには方法がいくつかあるが、terraform.tfvarsファイルに`変数名＝値`の形式で指定する事が多い。

変数名の値を設定する
``` 
# terraform.tfvars
subnet_cidr = "10.1.10.0/24"
```

## main.tfに変数をいれる

```
resource "aws_vpc" "tf_test" {
  cidr_block = "10.1.0.0/16"


  tags = {
    Name = "tf_test"
  }
}

resource "aws_subnet" "tf_test" {
  vpc_id     = aws_vpc.tf_test.id
  cidr_block = var.subnet_cidr # ここがハードコーディングだったのを変数に置き換え

  tags = {
    Name = "tf_test"
  }
}

```

こうする事でcidrを変えたい時はterraform.tfvarsの方を変えてあげるとmain.tfでも反映されるようになる。
