variable "region" {
  default = "us-east-1"
}

variable "name" {
  default = "lcorboproject"
}

provider "aws" {
  region = "${var.region}"
}

module "lcorbo_project" {
  source = "modules/aws_s3_create_bucket"
  name   = "${var.name}"
  region = "${var.region}"
}

output "lcorbo_project" {
  value = "${module.lcorbo_project.id}"
}

output "lcorbo_key" {
  value = "${module.lcorbo_project.aws_kms_key}"
}
