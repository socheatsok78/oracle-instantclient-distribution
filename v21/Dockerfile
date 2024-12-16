FROM scratch AS oic-release-amd64
ADD https://download.oracle.com/otn_software/linux/instantclient/2116000/instantclient-basic-linux.x64-21.16.0.0.0dbru.zip /instantclient-basiclite-linux.zip

FROM scratch AS oic-release-arm64
# No ARM64 release available, use AMD64

FROM oic-release-${TARGETARCH} AS oic-release

FROM alpine:latest AS oic
COPY --from=oic-release /instantclient-basiclite-linux.zip /tmp/instantclient-basiclite-linux.zip
RUN <<EOF
apk add --no-cache --virtual .build-deps unzip
mkdir -p /opt/oracle
unzip /tmp/instantclient-basiclite-linux.zip -d /opt/oracle
ln -s /opt/oracle/instantclient_*/ /opt/oracle/instantclient
EOF

FROM scratch
COPY --from=oic /opt/oracle /opt/oracle
