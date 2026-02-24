ARG VARIANT=basic

FROM scratch AS instantclient-basic-amd64
ADD https://download.oracle.com/otn_software/linux/instantclient/1912000/instantclient-basic-linux.x64-19.12.0.0.0dbru.zip /instantclient-linux.zip
FROM scratch AS instantclient-basic-arm64
# No ARM64 artifact found for basic, skipping

FROM scratch AS instantclient-basiclite-amd64
ADD https://download.oracle.com/otn_software/linux/instantclient/1912000/instantclient-basiclite-linux.x64-19.12.0.0.0dbru.zip /instantclient-linux.zip
FROM scratch AS instantclient-basiclite-arm64
# No ARM64 artifact found for basiclite, skipping

FROM instantclient-${VARIANT}-${TARGETARCH} AS instantclient

FROM ghcr.io/socheatsok78/unzip:latest AS oic
COPY --from=instantclient /instantclient-linux.zip /tmp/instantclient-linux.zip
RUN <<EOF
	mkdir -p /opt/oracle
	unzip /tmp/instantclient-linux.zip -d /opt/oracle
	ln -s /opt/oracle/instantclient_*/ /opt/oracle/instantclient
EOF

FROM scratch
COPY --from=oic /opt/oracle /opt/oracle
