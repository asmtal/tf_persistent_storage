module "project_atmos" {
  source = "github.com/singlestone/tf_aws_s3_create_bucket"
  name   = "${var.name}"
  region = "${var.region}"
}
