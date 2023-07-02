resource "aws_dynamodb_table" "app-nosql-db" {
  name         = "app-nosql-db"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  attribute {
    name = "id"
    type = "S"
  }
  tags = {
    Name = "app-nosql-db"
  }
}
