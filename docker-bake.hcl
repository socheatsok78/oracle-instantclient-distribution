variable "GITHUB_REPOSITORY" {
    default = "socheatsok78/oracle-instantclient-distribution"
}

target "github-metadata-action" {}

group "default" {
    targets = [
        "v19-default",
        "v21-default",
        "v23-default",
    ]
}

group "dev" {
    targets = [
        "v19",
        "v21",
        "v23",
    ]
}

# v19
target "v19" {
    inherits = ["github-metadata-action"]
    context = "v19"
    tags = [
        "${GITHUB_REPOSITORY}:v19"
    ]
}
target "v19-default" {
    inherits = ["v19"]
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
}

# v21
target "v21" {
    inherits = ["github-metadata-action"]
    context = "v21"
    platforms = [
        "linux/amd64",
    ]
    tags = [
        "${GITHUB_REPOSITORY}:v21"
    ]
}
target "v21-default" {
    inherits = ["v21"]
    platforms = [
        "linux/amd64",
    ]
}

# v23
target "v23" {
    inherits = ["github-metadata-action"]
    context = "v23"
    platforms = [
        "linux/amd64",
    ]
    tags = [
        "${GITHUB_REPOSITORY}:v23"
    ]
}
target "v23-default" {
    inherits = ["v23"]
    platforms = [
        "linux/amd64",
    ]
}
