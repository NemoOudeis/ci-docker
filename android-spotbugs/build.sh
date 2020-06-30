#!/usr/bin/env zsh
set -e

SPOTBUGS_VERSION=4.0.5
REPOSITORY=nemooudeis/android-spotbugs

for ANDROID_VERSION in 28.0.0 29.0.0
do  
  docker build \
    --build-arg spotbugs_version=${SPOTBUGS_VERSION} \
    --build-arg android_version=${ANDROID_VERSION} \
    --tag ${REPOSITORY} \
    --tag ${REPOSITORY}:${ANDROID_VERSION}-${SPOTBUGS_VERSION} \
    .
done

docker push ${REPOSITORY}
