resource "network" "main" {
  subnet = "10.77.42.0/24"
}

resource "container" "ubuntu" {
  image {
    name = "ubuntu"
  }

  resources {
    cpu    = 250
    memory = 256
  }

  network {
    id = resource.network.main.meta.id
  }
}

module "app" {
  source = "./modules/app"

  variables = {
    network_id = resource.network.main.meta.id
  }
}

resource "exec" "bootstrap" {
  script = "scripts/bootstrap.sh"
  target = module.app.output.container
}
