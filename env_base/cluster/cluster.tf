# cluster/cluster.tf 
resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.gcp_region
  network            = var.network_name
  subnetwork         = var.subnet_name

  initial_node_count = 1
  node_config {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.sa_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      foo = "bar"
    }
    tags = ["foo", "bar"]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
  enable_autopilot = true
}