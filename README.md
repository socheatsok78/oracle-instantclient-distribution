# About
The Oracle Instant Client distribution as container image

## Supported platforms
- `linux/amd64`
- `linux/arm64` * (Only for Oracle Instant Client v19.25)

## Usage

```Dockerfile
# Oracle Instant Client Distribution
FROM socheatsok78/oracle-instantclient-distribution:v19 AS oracle-instantclient-distribution

FROM alpine:latest
ENV PATH=/opt/oracle/instantclient:$PATH
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient:$LD_LIBRARY_PATH
RUN apk add --no-cache gcompat libaio
COPY --from=oracle-instantclient-distribution /opt/oracle /opt/oracle
```

## References
- https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
- https://www.oracle.com/database/technologies/instant-client/linux-arm-aarch64-downloads.html
