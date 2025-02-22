# Networking & Security Module

## Overview
This module provisions the networking and security components for the AI-powered Terraform module generator infrastructure on GCP.

## Resources Created
- **VPC & Subnets**
- **Firewall Rules**
- **IAM & Service Accounts**
- **Private Google Access**
- **Cloud NAT** (if needed for outbound traffic)

## Inputs
- `project_id` - GCP Project ID
- `region` - Deployment region
- `vpc_name` - Name of the VPC
- `subnet_ranges` - CIDR blocks for subnets

## Outputs
- `vpc_id` - ID of the created VPC
- `subnet_ids` - List of created subnet IDs
- `service_account_email` - IAM Service Account Email

## Usage Example
```hcl
module "networking" {
  source       = "./modules/networking"
  project_id   = "my-gcp-project"
  region       = "us-central1"
  vpc_name     = "my-vpc"
  subnet_ranges = ["10.0.1.0/24", "10.0.2.0/24"]
}
```

## Security Considerations
- Ensure **least privilege IAM roles** for service accounts.
- Enable **VPC Service Controls** if needed.
- Restrict firewall rules to allow only necessary traffic.

## Best Practices
- Use **private Google access** for secure Cloud SQL connections.
- Enable **Cloud NAT** if private outbound access is needed.