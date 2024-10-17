# S3バケット
resource "aws_s3_bucket" "remote_backend" {
  bucket = "terraform-s3-nakamura" # 被らない名前をつける
  lifecycle {                      # ライフサイクル
    prevent_destroy = true         # terraformでバケットを削除できないようにする設定 削除したい場合 false
  }

  tags = {
    Name        = "remote_backend_s3"
    Environment = "dev"
  }

}
# バージョニング有効化
resource "aws_s3_bucket_versioning" "remote_backend" {
  bucket = aws_s3_bucket.remote_backend.id # remote_backend.idでどのバケットのバージョニングを有効にするのか識別してる
  versioning_configuration {
    status = "Enabled"
  }

}
