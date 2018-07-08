terraform {
  backend "s3" {
    bucket     = "project-atmos20180708042644619000000001"
    key        = "terraform.tfstate"
    region     = "us-east-1"
    encrypt    = true
    kms_key_id = "arn:aws:kms:us-east-1:592342700041:key/20bad36c-6425-403e-91a4-c0b46d44e9d1"
  }
}
