#!/usr/bin/env zsh
set -e

VERSION=6.25.0
REPOSITORY=nemooudeis/pmd

docker build \
  --build-arg version=${VERSION} \
  --tag ${REPOSITORY} \
  --tag ${REPOSITORY}:${VERSION} \
  .

docker push ${REPOSITORY}
