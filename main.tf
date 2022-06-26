terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

resource "google_project_service" "project" {
  project = var.project
  service = "compute.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_address" "static_ip" {
  name         = "ubuntu-vm"
  network_tier = "STANDARD"
}

resource "random_password" "password" {
  length = 16
  special = true
  override_special = "@#%-_"
}

resource "google_compute_instance" "vm_instance" {
  name         = "shadowsocks"
  description  = "Shadowsocks Proxy Server using Terraform"
  machine_type = "f1-micro"
  zone         = var.zone
  tags = [
    "firewall-ssh",
    "firewall-http",
    "firewall-https",
    "firewall-icmp",
    "firewall-shadowsocks",
    "firewall-shadowsocks-udp",
    "firewall-ipv6-ssh",
    "firewall-ipv6-shadowsocks",
    "firewall-ipv6-shadowsocks-udp",
    "firewall-ipv6-icmp",
  ]
  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2204-lts"
    }
  }
 
  network_interface {
    subnetwork = google_compute_subnetwork.custom_subnet.name
    stack_type = "IPV4_IPV6"
    access_config {
      network_tier = "STANDARD"
      nat_ip	   = google_compute_address.static_ip.address
    }
    ipv6_access_config {
      network_tier = "PREMIUM"
    }
  }
  shielded_instance_config {
    enable_secure_boot = true
  }
  metadata = {
    sshKeys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
  metadata_startup_script = templatefile("./startup.sh", {password = random_password.password.result})
}

