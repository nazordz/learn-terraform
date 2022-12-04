terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.44.1"
    }
  }
}

provider "google" {
  project = "learn-terraform-370214"
  region = "southeast2"
  // example using service account file 
  credentials = "./learn-terraform-370214-65e46bdfc82f.json"
}

// declare variable 
variable "subnet_ip_cidr_range" {
  description = "Subnet for dev_subnet_01"
  type = string
#   type = list(string)
#   type = list(object({
#     name = string
#     range = string
#   }))
}
variable "subnet_secondary_ip_cidr_range" {
  description = "Subnet secondary"
  type = string
}

resource "google_compute_network" "development_network" {
    name = "development-network"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "dev_subnet_01" {
    name = "dev-subnet-01"
    ip_cidr_range = var.subnet_ip_cidr_range
    network = google_compute_network.development_network.id
    region = "asia-southeast2"
    secondary_ip_range = [ {
      ip_cidr_range = var.subnet_secondary_ip_cidr_range
      range_name = "secondary-range-01"
    } ]
}

// get existing resource
data "google_compute_network" "existing_default_network" {
  name = "default"
}

resource "google_compute_subnetwork" "dev_subnet_02" {
    name = "dev-subnet-02"
    ip_cidr_range = "10.110.0.0/16"
    network = data.google_compute_network.existing_default_network.id
    region = "asia-southeast2"
}

// output syntex are used to show value after code applied
output "development_network_id" {
  value = "google_compute_network.development_network.id"
}

output "dev_subnet_01_gateway" {
    value = "google_compute_subnetwork.dev_subnet_01.gateway_address"
}