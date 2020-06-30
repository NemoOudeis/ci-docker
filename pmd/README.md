# [PMD](https://pmd.github.io/) container, build for CI Pipelines

[![Docker Hub Pulls](https://img.shields.io/docker/pulls/nemooudeis/pmd.svg)](https://hub.docker.com/r/nemooudeis/pmd)

You can use this container to run [`pmd` and `cpd`](https://pmd.github.io/).

```shell
docker run --rm --mount type=bind,src=$(pwd),dst=/code nemooudeis/pmd pmd -d /code/src -R /code/pmd-ruleset.xml -f html -r pmd-report.html
docker run --rm --mount type=bind,src=$(pwd),dst=/code nemooudeis/pmd cpd --files /code/src --minimum-tokens 100
```

Or use it as a step within your build pipeline, in particular if other stuff is slow and you can run some static analysis in parallel e.g. with CircleCI

```yaml
jobs:
  ktlint:
    docker:
      - image: nemooudeis/pmd
    steps:
      - checkout
      - run: |
            mkdir reports
            pmd -d src -R pmd-ruleset.xml -f html -r reports/pmd-report.html
            pmd -d src -R pmd-ruleset.xml -f xml -r reports/pmd-report.xml
            cpd --files src --minimum-tokens 100 > reports/pmd-report.txt
      - store_artifacts:
          path: reports
```
