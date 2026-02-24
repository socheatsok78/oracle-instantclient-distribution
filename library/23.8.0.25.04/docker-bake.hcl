variable "GITHUB_REPOSITORY" {
  default = "socheatsok78/oracle-instantclient-distribution"
}

variable "VERSION" {
  default = "23.8.0.25.04"
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
    "linux/arm64",
  ]
  tags = [
    "${GITHUB_REPOSITORY}:${VERSION}-${VARIANT}",
  ]
}
