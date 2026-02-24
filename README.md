# About
The Oracle Instant Client distribution as container image

[Source](https://github.com/socheatsok78/oracle-instantclient-distribution) | [Docker Hub](https://hub.docker.com/r/socheatsok78/oracle-instantclient-distribution) | [GitHub Container Registry](https://ghcr.io/socheatsok78/oracle-instantclient-distribution)

## Supported versions
- `19.x.x.x.x-basic`, `19.x.x.x.x-basiclite`
- `21.x.x.x.x-basic`, `21.x.x.x.x-basiclite`
- `23.x.x.x.x-basic`, `23.x.x.x.x-basiclite`

Check the library directory for the exact versions available.

## Supported platforms
- `linux/amd64`
- `linux/arm64` * (Only available for later versions of Oracle Instant Client, e.g. v23)

## Usage

```Dockerfile
# Oracle Instant Client Distribution
ARG OICD_VERSION=23.26.1.0.0-basic
FROM socheatsok78/oracle-instantclient-distribution:${OICD_VERSION} AS oicd-distribution

# Final
FROM alpine:latest
ENV PATH=/opt/oracle/instantclient:$PATH
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient
RUN apk add --no-cache gcompat libaio
COPY --from=oicd-distribution /opt/oracle /opt/oracle
```

Some versions of Oracle Instant Client are only available for `linux/amd64` platform, so you may need to mix and match the versions and platforms as needed.

For example, if you want to use Oracle Instant Client v19 on `linux/arm64` platform and Oracle Instant Client v23 on `linux/amd64` platform, you can do the following:

```Dockerfile
FROM socheatsok78/oracle-instantclient-distribution:19.27.0.0.0-basic AS oicd-distribution-amd64
FROM socheatsok78/oracle-instantclient-distribution:23.26.1.0.0-basic AS oicd-distribution-arm64
FROM oicd-distribution-${TARGETARCH} AS oracle-instantclient

# Final
FROM alpine:latest
ENV PATH=/opt/oracle/instantclient:$PATH
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient
RUN apk add --no-cache gcompat libaio
COPY --from=oicd-distribution /opt/oracle /opt/oracle
```

## What is the difference between `basic` and `basiclite`?

- `basic` package includes all files required to run OCI, OCCI, and JDBC-OCI applications.
- `basiclite` package is a smaller version of the Basic package, with only English error messages and Unicode, ASCII, and Western European character set support.

## References
- https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
- https://www.oracle.com/database/technologies/instant-client/linux-arm-aarch64-downloads.html

## License

The Oracle Instant Client is licensed under the Oracle Technology Network License Agreement for Oracle Instant Client. Please refer to the [license agreement](https://www.oracle.com/downloads/licenses/instant-client-lic.html) for more details.
