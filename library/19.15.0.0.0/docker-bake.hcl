variable "GITHUB_REPOSITORY" {
  default = "socheatsok78/oracle-instantclient-distribution"
}

variable "VERSION" {
  default = "19.15.0.0.0"
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
