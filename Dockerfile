FROM debian:stable-slim AS builder

RUN apt update && apt install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x ./wp-cli.phar

FROM wordpress:latest AS wp-cli

LABEL maintainer="info@asabagh.ir"

COPY --from=builder /tmp/wp-cli.phar /usr/local/bin/wp

RUN chmod +x /usr/local/bin/wp

RUN apt update && apt install less && rm -rf /var/lib/apt/lists/*

RUN wp --info