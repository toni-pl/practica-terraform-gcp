# main.tf

# 1. Configuración de Terraform
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

# 2. Provider
provider "google" {
  credentials = file("credentials.json") 
  project     = "silver-fragment-481408-c9"
  region      = "europe-west1"
  zone        = "europe-west1-c"
}

# 3. Red Virtual
resource "google_compute_network" "vpc_terraform" {
  name                    = "vpc-terraform"
  auto_create_subnetworks = false 
}

# 4. Subred Explícita
resource "google_compute_subnetwork" "subred_terraform" {
  name          = "subred-terraform"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west1"
  network       = google_compute_network.vpc_terraform.id 
}

# 5. Firewall (Habilitar SSH)
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-terraform"
  network = google_compute_network.vpc_terraform.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# 6. Bucket de Almacenamiento
resource "google_storage_bucket" "bucket_terraform" {
  name          = "bucket-terraform-anzeni-481408" 
  location      = "EU"
  force_destroy = true 
  uniform_bucket_level_access = true
}

# 7. Máquina Virtual
resource "google_compute_instance" "vm_terraform" {
  name         = "vm-terraform"
  machine_type = "e2-micro"
  zone         = "europe-west1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_terraform.id
    subnetwork = google_compute_subnetwork.subred_terraform.id
    access_config {
    }
  }
}