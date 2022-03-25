resource "docker_image" "dokku" {
  name         = "dokku/dokku"
  keep_locally = true
}

resource "docker_container" "dokku" {
  name  = "dokku_lab"
  image = docker_image.dokku.latest

  env = [
    "DOKKU_HOSTNAME=dokku.me",
  ]

  dynamic "ports" {
    for_each = [
      { in : 80, ex : 8080 },
      { in : 433, ex : 8443 },
      { in : 22, ex : 3022 }
    ]
    content {
      internal = ports.value["in"]
      external = ports.value["ex"]
    }
  }

  dynamic "volumes" {
    for_each = [{ in : "/var/run/docker.sock", ex : "/var/run/docker.sock" }]
    content {
      container_path = volumes.value["in"]
      host_path      = volumes.value["ex"]
    }
  }

  upload {
    content = <<-EOF
      postgres: https://github.com/dokku/dokku-postgres.git
      redis: https://github.com/dokku/dokku-redis.git
    EOF

    file = "/var/lib/dokku/plugin-list"
  }
}
