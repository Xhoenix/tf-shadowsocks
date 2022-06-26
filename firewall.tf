resource "google_compute_firewall" "ssh" {
  name    = "firewall-ssh"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["firewall-ssh"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "ssh-ipv6" {
  name    = "firewall-ipv6-ssh"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["firewall-ipv6-ssh"]
  source_ranges = ["::/0"]
}

resource "google_compute_firewall" "http" {
  name    = "firewall-http"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["firewall-http"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "https" {
  name    = "firewall-https"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  target_tags   = ["firewall-https"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "icmp" {
  name    = "firewall-icmp"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "icmp"
  }

  target_tags   = ["firewall-icmp"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "icmp-ipv6" {
  name    = "firewall-ipv6-icmp"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "icmp"
  }

  target_tags   = ["firewall-ipv6-icmp"]
  source_ranges = ["::/0"]
}

resource "google_compute_firewall" "shadowsocks" {
  name    = "firewall-shadowsocks"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["8888"]
  }

  target_tags   = ["firewall-shadowsocks"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "shadowsocks_udp" {
  name    = "firewall-shadowsocks-udp"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "udp"
    ports    = ["8888"]
  }

  target_tags   = ["firewall-shadowsocks-udp"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "ipv6-shadowsocks" {
  name    = "firewall-ipv6-shadowsocks"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["8888"]
  }

  target_tags   = ["firewall-ipv6-shadowsocks"]
  source_ranges = ["::/0"]
}

resource "google_compute_firewall" "ipv6-shadowsocks_udp" {
  name    = "firewall-ipv6-shadowsocks-udp"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "udp"
    ports    = ["8888"]
  }

  target_tags   = ["firewall-ipv6-shadowsocks-udp"]
  source_ranges = ["::/0"]
}


