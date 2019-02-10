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

resource "google_compute_instance" "vm_instance" {
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
