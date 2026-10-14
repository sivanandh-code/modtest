resource "container" "app" {
  image {
    name = "nginx:alpine"
  }

  network {
    id = variable.network_id
  }
}
