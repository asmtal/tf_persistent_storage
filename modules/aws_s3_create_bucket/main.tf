provider "aws" {
  region = "${var.region}"
}

variable "name" {}
variable "region" {}

resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "${var.name}"
  acl           = "private"

  versioning {
    enabled = true
  }

  tags {
    Name        = "My bucket"
    Environment = "Dev"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.mykey.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_policy" "force_encrpyt" {
  bucket = "${aws_s3_bucket.bucket.id}"
  policy = <<POLICY
{
       "Version": "2012-10-17",
       "Id": "PutObjPolicy",
       "Statement": [
             {
                  "Sid": "DenyIncorrectEncryptionHeader",
                  "Effect": "Deny",
                  "Principal": "*",
                  "Action": "s3:PutObject",
                  "Resource": "${aws_s3_bucket.bucket.arn}/*",
                  "Condition": {
                          "StringNotEquals": {
                                 "s3:x-amz-server-side-encryption": "AES256"
                           }
                  }
             },
             {
                  "Sid": "DenyUnEncryptedObjectUploads",
                  "Effect": "Deny",
                  "Principal": "*",
                  "Action": "s3:PutObject",
                  "Resource": "${aws_s3_bucket.bucket.arn}/*",
                  "Condition": {
                          "Null": {
                                 "s3:x-amz-server-side-encryption": true
                          }
                 }
             }
       ]
}
POLICY

}

output "id" {
  value = "${aws_s3_bucket.bucket.id}"
}

output "aws_kms_key" {
  value = "${aws_kms_key.mykey.arn}"
}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 30
}
