variable "GITHUB_REPOSITORY" {
    default = "socheatsok78/oracle-instantclient-distribution"
}

target "docker-metadata-action" {}
target "github-metadata-action" {}
target "instantclient" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
    ]
}
target "instantclient-basic" {
    args = {
        PACKAGE = "basic"
    }
}
target "instantclient-basiclite" {
    args = {
        PACKAGE = "basiclite"
    }
}

group "default" {
    targets = [
        "v19",
        "v19-lite",
        "v21",
        "v21-lite",
        "v23",
        "v23-lite",
    ]
}

group "dev" {
    targets = [
        "v19-dev",
        "v19-lite-dev",
    ]
}

# v19
target "v19" {
    inherits = [ "instantclient", "instantclient-basic" ]
    context = "v19"
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
}
target "v19-lite" {
    inherits = [ "instantclient", "instantclient-basiclite" ]
    context = "v19"
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
}
target "v19-dev" {
    inherits = [ "instantclient", "instantclient-basic" ]
    context = "v19"
    tags = [
        "${GITHUB_REPOSITORY}:v19"
    ]
}
target "v19-lite-dev" {
    inherits = [ "instantclient", "instantclient-basiclite" ]
    context = "v19"
    tags = [
        "${GITHUB_REPOSITORY}:v19-lite"
    ]
}

# v21
target "v21" {
    inherits = [ "instantclient", "instantclient-basic" ]
    context = "v21"
    platforms = [
        "linux/amd64",
    ]
}
target "v21-lite" {
    inherits = [ "instantclient", "instantclient-basic" ]
    context = "v21"
    platforms = [
        "linux/amd64",
    ]
}
target "v21-dev" {
    inherits = [ "instantclient", "instantclient-basic" ]
    context = "v21"
    tags = [
        "${GITHUB_REPOSITORY}:v21"
    ]
}

# v23
target "v23" {
    inherits = [ "instantclient", "instantclient-basic" ]
    context = "v23"
    platforms = [
        "linux/amd64",
    ]
}
target "v23-lite" {
    inherits = [ "instantclient", "instantclient-basic" ]
    context = "v23"
    platforms = [
        "linux/amd64",
    ]
}
target "v23-dev" {
    inherits = [ "instantclient", "instantclient-basic" ]
    context = "v23"
    tags = [
        "${GITHUB_REPOSITORY}:v23"
    ]
}
