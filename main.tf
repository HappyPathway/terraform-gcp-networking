terraform {
  required_version = ">= 1.0.0"
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 7.0"

  project_id   = var.project_id
  network_name = "${var.project_id}-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "${var.project_id}-subnet"
      subnet_ip             = "10.0.0.0/20"
      subnet_region         = var.region
      subnet_private_access = true
    }
  ]

  secondary_ranges = {
    "${var.project_id}-subnet" = [
      {
        range_name    = "pods"
        ip_cidr_range = "10.1.0.0/16"
      },
      {
        range_name    = "services"
        ip_cidr_range = "10.2.0.0/16"
      }
    ]
  }
}

# Cloud NAT for private GKE clusters
resource "google_compute_router" "router" {
  name    = "${var.project_id}-router"
  network = module.vpc.network_name
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.project_id}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

output "vpc_network_name" {
  value = module.vpc.network_name
}

output "subnet_name" {
  value = module.vpc.subnets_names[0]
}
