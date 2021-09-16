FROM azul/zulu-openjdk-alpine:16-jre

WORKDIR /root/
ARG spotbugs_version=none
ENV SPOTBUGS_HOME=/root/spotbugs-${spotbugs_version}
ENV PATH="${SPOTBUGS_HOME}/bin:${PATH}"
RUN wget https://github.com/spotbugs/spotbugs/releases/download/${spotbugs_version}/spotbugs-${spotbugs_version}.zip \
 && unzip -o spotbugs-${spotbugs_version}.zip \
 && rm spotbugs-${spotbugs_version}.zip \
 && chmod a+x ${SPOTBUGS_HOME}/bin/spotbugs 