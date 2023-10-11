# docker-gen is a file generator that renders templates using docker container meta-data.
FROM nginxproxy/docker-gen:0.10.6 AS docker-gen

# Foreman in Go. Profile
FROM nginxproxy/forego:0.17.2 AS forego

# Proxy
FROM quay.io/vouch/vouch-proxy:0.39.0 AS vouch

FROM alpine:3.18

# Install Forego + docker-gen + vouch
COPY --from=forego /usr/local/bin/forego /usr/local/bin/forego
COPY --from=docker-gen /usr/local/bin/docker-gen /usr/local/bin/docker-gen
COPY --from=vouch /vouch-proxy /usr/local/bin/vouch-proxy
RUN mkdir /usr/local/bin/config

# vouch-proxy need bash
RUN apk add --no-cache bash

COPY app /app/

WORKDIR /app

ENTRYPOINT ["forego", "start", "-r"]