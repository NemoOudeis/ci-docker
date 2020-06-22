ARG android_version=none

FROM cimg/android:${android_version}

WORKDIR /root/
ARG spotbugs_version=none
ENV SPOTBUGS_HOME /root/spotbugs-${spotbugs_version}
RUN wget https://github.com/spotbugs/spotbugs/releases/download/${spotbugs_version}/spotbugs-${spotbugs_version}.zip \
 && unzip -o spotbugs-${spotbugs_version}.zip \
 && rm spotbugs-${spotbugs_version}.zip \
 && chmod a+x ${SPOTBUGS_HOME}/bin/spotbugs 
 
ENV PATH="${SPOTBUGS_HOME}/bin:${PATH}"