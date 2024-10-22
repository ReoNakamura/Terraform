output "vpc_id" {

  description = "ID fo project VPC"
  value       = "aws_vpc.tf_test.id"
}

output "vpc_arn" {
  value = "aws_vpc.tf_test.id"
}

output "subnet" {
  value = "aws_subnet.tf.test"

}
