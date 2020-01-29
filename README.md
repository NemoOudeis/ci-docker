# Containers for CI/CD Pipelines

This repo collects docker files for use in CI/CD pipelines.

## [ktlint](https://hub.docker.com/repository/docker/nemooudeis/ktlint)

```shell
version=X.Y.Z
docker build --build-arg version=${version} ktlint -t nemooudeis/ktlint -t nemooudeis/ktlint:${version}
docker push nemooudeis/ktlint
```

## [android-sdk](https://hub.docker.com/repository/docker/nemooudeis/android-sdk)

```shell
cd android-sdk
./build.sh
```