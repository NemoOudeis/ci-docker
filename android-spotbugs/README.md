# [SpotBugs](https://github.com/spotbugs/spotbugs) on CircleCI Android Containers

[![Docker Hub Pulls](https://img.shields.io/docker/pulls/nemooudeis/android-spotbugs.svg)](https://hub.docker.com/r/nemooudeis/android-spotbugs)

Built to run SpotBugs on CI, outside of `gradle`, in parallel to other jobs. SpotBugs operates on bytecode, so you need to compile the classes first, either in a previous job (and pass it via the workspace) or compile inside the `spotbugs` step (only compiling java tends to be faster than the full android build cycle by factor of 10).

You can run it locally:

```shell
docker run --rm --mount type=bind,src=$(pwd),dst=/code nemooudeis/android-spotbugs spotbugs "/code/build/intermediates/javac/"
```

Or use it as a step within your build pipeline:

```yaml
jobs:
  spotbugs:
    docker:
      - image: nemooudeis/android-spotbugs:28.0.0-4.0.5
    steps:
      - checkout
      - run:
          name: Compile java classes
          command: |
            ./gradlew compileReleaseSources
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
