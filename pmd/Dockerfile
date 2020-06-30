FROM adoptopenjdk:14-jre-hotspot


ARG version=none
ENV PMD_HOME /root/pmd-bin-${version}

# Install git and openssh-client for CircleCI
RUN apt-get update \
    && apt-get install -y --no-install-recommends git openssh-client wget unzip \
    && rm -rf /var/lib/apt/lists/* \
    && cd $HOME \
    && wget https://github.com/pmd/pmd/releases/download/pmd_releases%2F${version}/pmd-bin-${version}.zip \
    && unzip pmd-bin-${version}.zip \
    && apt-get remove -y wget unzip \
    && rm $PMD_HOME/bin/*.bat \
    && echo '#!/bin/bash\n$PMD_HOME/bin/run.sh pmd "$@"' > /usr/bin/pmd \
    && chmod +x /usr/bin/pmd \
    && echo '#!/bin/bash\n$PMD_HOME/bin/run.sh cpd "$@"' > /usr/bin/cpd \
    && chmod +x /usr/bin/cpd
