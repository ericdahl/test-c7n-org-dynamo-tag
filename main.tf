provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "default" {
  name = "c7n-test"
  hash_key = "id"

  read_capacity = 1
  write_capacity = 1

  "attribute" {
    name = "id"
    type = "S"
  }

  tags {
    Name = "c7n-test"
  }
}

resource "aws_dynamodb_table" "without_name" {
  name = "c7n-test-without-name"
  hash_key = "id"

  read_capacity = 1
  write_capacity = 1

  "attribute" {
    name = "id"
    type = "S"
  }
}