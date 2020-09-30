# [ktlint](https://ktlint.github.io/) container, build for CI Pipelines

[![Docker Hub Pulls](https://img.shields.io/docker/pulls/nemooudeis/ktlint.svg)](https://hub.docker.com/r/nemooudeis/ktlint)

You can use this container to run [`ktlint`](https://ktlint.github.io/) without installation (maybe on a remote machine)

```shell
docker run --rm --mount type=bind,src=$(pwd),dst=/code nemooudeis/ktlint ktlint "/code/**/*.kt"
```

Or use it as a step within your build pipeline, in particular if your test are slow and fast feedback of ktlint is valuable, e.g. with CircleCI

```yaml
jobs:
  ktlint:
    docker:
      - image: nemooudeis/ktlint
    steps:
      - checkout
      - run:
          name: ktlint to check for code style violations in changes between PR and origin/master
          command: |
            set +e # allow grep to fail without failing the whole step (in cases no kotlin files were changed)
            files=$(git diff $(git show-ref origin/master -s) HEAD --name-only --relative | grep '\.kt[s"]\?$')
            [ -z "$files" ] && echo "no kotin files changed, all good!" && exit 0
            echo $files | xargs ktlint --relative .

  build: # actual build, test, deploy etc jobs

workflows:
  version: 2
  build_and_publish:
    jobs:
      - ktlint
      - build:
          requires:
            - ktlint
```
