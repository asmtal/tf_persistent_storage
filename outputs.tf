output "project_atmos" {
  value = "${module.project_atmos.id}"
}

output "atmos_key" {
  value = "${module.project_atmos.aws_kms_key}"
}
