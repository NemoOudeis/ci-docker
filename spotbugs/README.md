# [SpotBugs](https://github.com/spotbugs/spotbugs) on CircleCI Android Containers

[![Docker Hub Pulls](https://img.shields.io/docker/pulls/nemooudeis/spotbugs.svg)](https://hub.docker.com/r/nemooudeis/spotbugs)

Built on top of [`azul/zulu-openjdk-alpine`](https://hub.docker.com/r/azul/zulu-openjdk-alpine), to run SpotBugs on CI, outside of `gradle`, in parallel to other jobs. SpotBugs operates on bytecode, so you need to compile the classes first, in a previous job and pass it via the workspace.

You can run it locally:

```shell
docker run --rm --mount type=bind,src=$(pwd),dst=/code nemooudeis/spotbugs spotbugs "/code/build/intermediates/javac/"
```

Or use it as a step within your build pipeline (example is circle CI):

```yaml
jobs:
  spotbugs:
    docker:
      - image: nemooudeis/spotbugs:4.4.1
    steps:
      # compile sources first and stash them in a workspace.
      - attach_workspace:
          at: .
      - run:
          name: Spotbugs
          command: |
            mkdir spotbugs
            spotbugs -html -output spotbugs/spotbugs-report.html \
                -exclude spotbugs-filter.xml \
                -longBugCodes -quiet \
                -effort:max \
                -low \
                build/intermediates/javac/
            spotbugs -xml -output spotbugs/spotbugs-report.xml \
                -exclude spotbugs-filter.xml \
                -longBugCodes -quiet \
                -effort:max \
                -low \
                build/intermediates/javac/
      - store_artifacts:
          path: spotbugs # to view HTML report
      - persist_to_workspace:
          root: .
          paths:
            - coverage # to process XML report in other jobs
```
