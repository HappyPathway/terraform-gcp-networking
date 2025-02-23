variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for resource deployment"
  type        = string
}

output "vpc_network_name" {
  value = module.vpc.network_name
}

output "subnet_name" {
  value = module.vpc.subnets_names[0]
}

output "network_self_link" {
  value = module.vpc.network_self_link
}
