output "public_ip" {
  value = google_compute_address.static_ip.address
}

output "sss_password" {
  value = random_password.password.result
  sensitive = true
}
