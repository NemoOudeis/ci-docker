#!/usr/bin/env zsh
set -e

if [ "$#" -ne 1 ]; 
then
  echo "Usage: $0 SPOTBUGS_VERSION" >&2
  exit 1
fi

SPOTBUGS_VERSION=${1}
REPOSITORY=nemooudeis/spotbugs

docker build \
  --build-arg spotbugs_version=${SPOTBUGS_VERSION} \
  --tag ${REPOSITORY} \
  --tag ${REPOSITORY}:${SPOTBUGS_VERSION} \
  .

docker push ${REPOSITORY}
docker push ${REPOSITORY}:${SPOTBUGS_VERSION}
