provider "google" {
  project = "testing-project-231215"
  credentials = "${file("sa-testing-project.json.secret")}"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "testing-network" {
  name                    = "testing-network1"
  description             = "testing out configuring new networks"
  auto_create_subnetworks = "true"
}

resource "google_compute_instance" "testing-instance" {
  name         = "testing-instance1"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
    }
  }

  network_interface {
    network       = "${google_compute_network.testing-network.self_link}"
    access_config = {
    }
  }
}

resource "google_dns_record_set" "testing-instance-dns" {
  name         = "vpn.${google_dns_managed_zone.testing-zone.dns_name}"
  type         = "A"
  ttl          = 300
  managed_zone = "${google_dns_managed_zone.testing-zone.name}"
  rrdatas      = ["${google_compute_instance.testing-instance.network_interface.0.access_config.0.nat_ip}"]
}

resource "google_dns_managed_zone" "testing-zone" {
  name        = "testing-zone"
  dns_name    = "${var.dns_zone}."
  description = "Purchase the domain prior to this."
}
