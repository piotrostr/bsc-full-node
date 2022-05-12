variable "project_id" {}
variable "name" {}
variable "machine_type" {}
variable "image" {}
variable "network" {}
variable "zone" {}

resource "google_compute_instance" "vm_instance" {
  name         = var.name
  machine_type = var.machine_type
  project      = var.project_id
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = var.network
    access_config {
      // ephemeral public ip
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = format("${var.project_id}-vpc", )
  auto_create_subnetworks = "true"
  project                 = var.project_id
}
