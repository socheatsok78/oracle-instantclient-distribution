variable "GITHUB_REPOSITORY" {
    default = "socheatsok78/oracle-instantclient-distribution"
}

target "docker-metadata-action" {}
target "github-metadata-action" {}

group "default" {
    targets = [
        "v19",
        "v21",
        "v23",
    ]
}

group "dev" {
    targets = [
        "v19-dev",
        "v21-dev",
        "v23-dev",
    ]
}

# v19
target "v19" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
    ]
    context = "v19"
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
}
target "v19-dev" {
    context = "v19"
    tags = [
        "${GITHUB_REPOSITORY}:v19"
    ]
}

# v21
target "v21" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
    ]
    context = "v21"
    platforms = [
        "linux/amd64",
    ]
}
target "v21-dev" {
    context = "v21"
    tags = [
        "${GITHUB_REPOSITORY}:v21"
    ]
}

# v23
target "v23" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
    ]
    context = "v23"
    platforms = [
        "linux/amd64",
    ]
}
target "v23-dev" {
    context = "v23"
    tags = [
        "${GITHUB_REPOSITORY}:v23"
    ]
}
