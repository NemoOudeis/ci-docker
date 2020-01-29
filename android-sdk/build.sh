#!/bin/bash
set -e

REPOSITORY=nemooudeis/android-sdk

TAG_VERSION=(
  jdk8
  # jdk11 
)
# sdk manager doesn't run on java 11 since they removed JAXB
# see https://www.oracle.com/technetwork/java/javase/11-relnote-issues-5012449.html#JDK-8190378
JDK_IMAGE=(
  adoptopenjdk:8u232-b09-jdk-hotspot
  adoptopenjdk:11.0.5_10-jdk-hotspot
)

echo "================================================"
echo "Building android SDK image"
echo "================================================"
docker build \
    --pull \
    --tag android-sdk \
    android-sdk

for ((i=0;i<${#JDK_IMAGE[@]};++i)); do
    TAG=${REPOSITORY}:${TAG_VERSION[i]}

    echo "================================================"
    echo "Building ${TAG} image"
    echo "================================================"

    docker build \
        --tag ${TAG} \
        --build-arg JDK_IMAGE=${JDK_IMAGE[i]} \
        jdk
done

docker push ${REPOSITORY}
