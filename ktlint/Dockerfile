FROM openjdk:jre-slim

RUN apt-get -qq update --yes \
 && apt-get -qq install --yes --no-install-recommends \
    curl \
    ca-certificates \
    git \
 && rm -rf /var/lib/apt/lists/*

# Download ktlint
ARG version=none
RUN curl -sSLO https://github.com/pinterest/ktlint/releases/download/${version}/ktlint \
 && chmod a+x ktlint \
 && mv ktlint /usr/local/bin