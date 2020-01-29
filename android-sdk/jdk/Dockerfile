ARG JDK_IMAGE=none

FROM android-sdk as android-sdk

FROM ${JDK_IMAGE}

# Android SDK
ARG android_home=/android-sdk
COPY --from=android-sdk /android-sdk ${android_home}

# Set environmental variables
ENV ANDROID_HOME ${android_home}
ENV ADB_INSTALL_TIMEOUT 120
ENV PATH=${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}
ENV TERM dumb

# Install git and openssh-client for CircleCI
RUN apt-get update \
    && apt-get install -y --no-install-recommends git openssh-client \
    && rm -rf /var/lib/apt/lists/* && \
    yes | sdkmanager --licenses && yes | sdkmanager --update && \
    sdkmanager \
        "tools" \
        "platform-tools" \
        "build-tools;28.0.3" \
        "build-tools;29.0.1" \
        "build-tools;29.0.2" \
        "platforms;android-28" \
        "platforms;android-29"
