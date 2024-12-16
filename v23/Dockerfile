FROM scratch AS oic-release-amd64
ADD https://download.oracle.com/otn_software/linux/instantclient/2360000/instantclient-basic-linux.x64-23.6.0.24.10.zip /instantclient-basiclite-linux.zip

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
