variable "GITHUB_REPOSITORY" {
    default = "socheatsok78/oracle-instantclient-distribution"
}

variable "ORACLE_INSTANTCLIENT_VERSION" {
    validation {
        condition = ORACLE_INSTANTCLIENT_VERSION != ""
        error_message = "The variable 'ORACLE_INSTANTCLIENT_VERSION' must not be empty."
    }
}

target "docker-metadata-action" {}
target "github-metadata-action" {}
target "buildx-bake-metadata" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
    ]
}

group "default" {
    targets = [
        "instantclient-pkg-basic",
        "instantclient-pkg-basiclite",
    ]
}

target "instantclient-pkg-basic" {
  args = {
    ORACLE_INSTANTCLIENT_VARIANT = "basic"
    ORACLE_INSTANTCLIENT_VERSION = ORACLE_INSTANTCLIENT_VERSION
  }
  tags = [
    "${GITHUB_REPOSITORY}:${ORACLE_INSTANTCLIENT_VERSION}",
    "${GITHUB_REPOSITORY}:${ORACLE_INSTANTCLIENT_VERSION}-basic",
  ]
}

target "instantclient-pkg-basiclite" {
  args = {
    ORACLE_INSTANTCLIENT_VARIANT = "basiclite"
    ORACLE_INSTANTCLIENT_VERSION = ORACLE_INSTANTCLIENT_VERSION
  }
  tags = [
    "${GITHUB_REPOSITORY}:${ORACLE_INSTANTCLIENT_VERSION}-basiclite",
  ]
}
