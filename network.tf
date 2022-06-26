resource "google_compute_network" "vpc_network" {
  name                     = "tf-ss-network"
  description              = "A custom VPC network for shadowsocks server"
  auto_create_subnetworks  = false
  enable_ula_internal_ipv6 = true
}

resource "google_compute_subnetwork" "custom_subnet" {

  name             = "custom-ds-subnet"
  description      = "A custom dual-stack subnet."
  ip_cidr_range    = "10.128.0.0/20"
  region           = var.region
  stack_type       = "IPV4_IPV6"
  ipv6_access_type = "EXTERNAL"
  network          = google_compute_network.vpc_network.id
}
