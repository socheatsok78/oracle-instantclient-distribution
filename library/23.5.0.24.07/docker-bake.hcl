variable "GITHUB_REPOSITORY" {
  default = "socheatsok78/oracle-instantclient-distribution"
}

variable "VERSION" {
  default = "23.5.0.24.07"
}

target "docker-metadata-action" {}

target "github-metadata-action" {}

target "default" {
  matrix = {
    "VARIANT" = [
      "basic",
      "basiclite",
    ]
  }
  name = "${VARIANT}"
  args = {
    "VARIANT" = VARIANT
  }
  platforms = [
    "linux/amd64",
  ]
  tags = [
    "${GITHUB_REPOSITORY}:${VERSION}-${VARIANT}",
  ]
}
