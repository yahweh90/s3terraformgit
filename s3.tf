resource "aws_s3_bucket" "bucket" {
  bucket = "mortalblade"

  tags = {
    Name        = "Build Stage"
    Environment = "Dev"
  }
}

#Bucket Objects
resource "aws_s3_object" "file" {
  bucket = aws_s3_bucket.bucket.id
  key    = "index.html"
 source = "C:/Users/yahsh/terraform and s3/index.html"
 content_type = "text/html"
}

#adding object/image
resource "aws_s3_object" "image"{

 bucket = aws_s3_bucket.bucket.id
 key    = "koi2.jpeg"
 source = "C:/Users/yahsh/terraform and s3/koi2.jpeg"
 content_type = "image/jpeg"
}

#adding object/image2
resource "aws_s3_object" "image2"{

 bucket = aws_s3_bucket.bucket.id
 key    = "hot-asian-women-3.jpeg"
 source = "C:/Users/yahsh/terraform and s3/hot-asian-women-3.jpeg"
 content_type = "image/jpeg"
}


#adding object/image3
resource "aws_s3_object" "image3"{

 bucket = aws_s3_bucket.bucket.id
 key    = "hajia-bintu.jpeg"
 source = "C:/Users/yahsh/terraform and s3/hajia-bintu.jpeg"
 content_type = "image/jpeg"
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  /*error_document {
    key = "error.html"
  }*/
}

resource "aws_s3_bucket_policy" "site" {
  depends_on = [
    aws_s3_bucket.bucket,
    aws_s3_bucket_public_access_block.public_access_block
  ]

  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*"
        ]
      },
    ]
  })
}

/*#resource "aws_s3_object" "upload_html" {
  for_each     = fileset("${path.module}/", "*.html")
  bucket       = aws_s3_bucket.bucket.id
  key          = each.value
  source       = "${path.module}/${each.value}"
  etag         = filemd5("${path.module}/${each.value}")
  content_type = "text/html"
}

resource "aws_s3_object" "upload_images" {
  for_each     = fileset("${path.module}/", "*.jpeg")
  bucket       = aws_s3_bucket.bucket.id
  key          = each.value
  source       = "${path.module}/${each.value}"
  etag         = filemd5("${path.module}/${each.value}")
  content_type = "image/jpeg"
}*/
