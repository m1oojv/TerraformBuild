resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-protoslabs"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }

}
/*
resource "aws_vpc_endpoint_service" "s3" {
  acceptance_required        = false
  allowed_principals = [aws_s3_bucket.b.arn]
}*/

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.ap-southeast-1.s3"

    route_table_ids =[
      aws_route_table.private-route-table-1.id
  ]

}
