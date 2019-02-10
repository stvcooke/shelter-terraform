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
