variable "DOCKER_IMAGE" {
    default = "socheatsok78/oracle-instantclient-distribution"
}

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
    context = "v19"
    tags = [
        "${DOCKER_IMAGE}:v19"
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
    context = "v21"
    platforms = [
        "linux/amd64",
    ]
    tags = [
        "${DOCKER_IMAGE}:v21"
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
    context = "v23"
    platforms = [
        "linux/amd64",
    ]
    tags = [
        "${DOCKER_IMAGE}:v23"
    ]
}
target "v23-default" {
    inherits = ["v23"]
    platforms = [
        "linux/amd64",
    ]
}
