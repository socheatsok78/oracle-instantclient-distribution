# About
The Oracle Instant Client distribution as container image

[Source](https://github.com/socheatsok78/oracle-instantclient-distribution) | [Docker Hub](https://hub.docker.com/r/socheatsok78/oracle-instantclient-distribution) | [GitHub Container Registry](https://ghcr.io/socheatsok78/oracle-instantclient-distribution)

## Tags
- `v19`, `v19-lite`
- `v21`, `v21-lite`
- `v23`, `v23-lite`

## Supported platforms
- `linux/amd64`
- `linux/arm64` * (Only available for Oracle Instant Client v19)

## Usage

```Dockerfile
# Oracle Instant Client Distribution
FROM socheatsok78/oracle-instantclient-distribution:v19 AS oicd-distribution

# Final
FROM alpine:latest
ENV PATH=/opt/oracle/instantclient:$PATH
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient
RUN apk add --no-cache gcompat libaio
COPY --from=oicd-distribution /opt/oracle /opt/oracle
```

If you are using multi-platform build, you can use the following workaround to build the image for both `linux/amd64` and `linux/arm64`:

```Dockerfile
FROM socheatsok78/oracle-instantclient-distribution:v23 AS oicd-distribution-amd64
FROM socheatsok78/oracle-instantclient-distribution:v19 AS oicd-distribution-arm64
FROM oicd-distribution-${TARGETARCH} AS oracle-instantclient

# Final
FROM alpine:latest
ENV PATH=/opt/oracle/instantclient:$PATH
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient
RUN apk add --no-cache gcompat libaio
COPY --from=oicd-distribution /opt/oracle /opt/oracle
```

## References
- https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
- https://www.oracle.com/database/technologies/instant-client/linux-arm-aarch64-downloads.html
