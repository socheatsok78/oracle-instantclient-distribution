ARG PACKAGE=basic

FROM scratch AS instantclient-basic-amd64
ADD https://download.oracle.com/otn_software/linux/instantclient/2360000/instantclient-basic-linux.x64-23.6.0.24.10.zip /instantclient-linux.zip
FROM scratch AS instantclient-basic-arm64
# No ARM64 release available, use AMD64
FROM scratch AS instantclient-basiclite-amd64
ADD https://download.oracle.com/otn_software/linux/instantclient/2360000/instantclient-basic-linux.x64-23.6.0.24.10.zip /instantclient-linux.zip
FROM scratch AS instantclient-basiclite-arm64
# No ARM64 release available, use AMD64

FROM instantclient-${PACKAGE}-${TARGETARCH} AS instantclient

FROM alpine:latest AS oic
COPY --from=instantclient /instantclient-linux.zip /tmp/instantclient-linux.zip
RUN <<EOF
apk add --no-cache --virtual .build-deps unzip
mkdir -p /opt/oracle
unzip /tmp/instantclient-linux.zip -d /opt/oracle
ln -s /opt/oracle/instantclient_*/ /opt/oracle/instantclient
EOF

FROM scratch
COPY --from=oic /opt/oracle /opt/oracle
