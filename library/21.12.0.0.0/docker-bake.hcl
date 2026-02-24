variable "GITHUB_REPOSITORY_OWNER" {
  default = "socheatsok78"
}

variable "GITHUB_REPOSITORY" {
  default = "${GITHUB_REPOSITORY_OWNER}/docker-oracle-instantclient"
}

variable "VERSION" {
  default = "21.12.0.0.0"
}

target "docker-metadata-action" {}

target "github-metadata-action" {}

group "default" {
  targets = [
    "oracle-instantclient-basic",
    "oracle-instantclient-basiclite",
  ]
}

target "oracle-instantclient-basic" {
  inherits = [
    "docker-metadata-action",
    "github-metadata-action",
  ]
  args = {
    "VARIANT" = "basic"
  }
  platforms = [
    "linux/amd64",
  ]
  tags = [
    "docker.io/${replace(GITHUB_REPOSITORY, "docker-", "")}:${VERSION}",
    "ghcr.io/${replace(GITHUB_REPOSITORY, "docker-", "")}:${VERSION}",
    "docker.io/${replace(GITHUB_REPOSITORY, "docker-", "")}:${VERSION}-basic",
    "ghcr.io/${replace(GITHUB_REPOSITORY, "docker-", "")}:${VERSION}-basic",
  ]
}

target "oracle-instantclient-basiclite" {
  inherits = [
    "docker-metadata-action",
    "github-metadata-action",
  ]
  args = {
    "VARIANT" = "basiclite"
  }
  platforms = [
    "linux/amd64",
  ]
  tags = [
    "docker.io/${replace(GITHUB_REPOSITORY, "docker-", "")}:${VERSION}-basiclite",
    "ghcr.io/${replace(GITHUB_REPOSITORY, "docker-", "")}:${VERSION}-basiclite",
  ]
}
