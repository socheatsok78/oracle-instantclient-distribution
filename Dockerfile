ARG ORACLE_INSTANTCLIENT_VERSION
ARG ORACLE_INSTANTCLIENT_VARIANT

FROM alpine:latest AS oic
RUN apk add --no-cache bash curl unzip
ADD ./instantclient.sh /usr/local/bin/instantclient.sh
RUN chmod +x /usr/local/bin/instantclient.sh

FROM oic AS instantclient
ARG TARGETARCH
ARG ORACLE_INSTANTCLIENT_VERSION
ARG ORACLE_INSTANTCLIENT_VARIANT
WORKDIR /rootfs
RUN instantclient.sh download --version ${ORACLE_INSTANTCLIENT_VERSION} --variant ${ORACLE_INSTANTCLIENT_VARIANT} --arch ${TARGETARCH}
RUN mkdir -p opt/oracle && \
    unzip "instantclient-${ORACLE_INSTANTCLIENT_VARIANT}-linux.${TARGETARCH}-${ORACLE_INSTANTCLIENT_VERSION}.zip" -d opt/oracle && \
    ln -s opt/oracle/instantclient_*/ opt/oracle/instantclient

FROM scratch
COPY --from=instantclient /rootfs/ /
