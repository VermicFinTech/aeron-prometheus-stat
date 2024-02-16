#
# Copyright 2018 Fairtide Pte. Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM ghcr.io/vermicfintech/vermiculus-temurin:17.0.6_10-jdk-v2

ADD https://releases.hashicorp.com/consul/1.14.5/consul_1.14.5_linux_amd64.zip /tmp

RUN apt-get update && apt-get install dos2unix && apt-get install -y -q unzip

COPY . /aeron-prometheus-stats/

RUN mkdir -p /opt/aeron-prometheus-stats/lib
RUN ls /aeron-prometheus-stats/
RUN dos2unix /aeron-prometheus-stats/gradlew
RUN cd  /aeron-prometheus-stats/ && ./gradlew fatJar
RUN cp /aeron-prometheus-stats/build/libs/aeron-prometheus-stats-all-1.0-SNAPSHOT.jar /opt/aeron-prometheus-stats/lib
RUN unzip -d /aeron-prometheus-stats /tmp/consul_1.14.5_linux_amd64.zip


ARG IMAGE_DATE
ARG IMAGE_VERSION

LABEL org.opencontainers.image.source="https://github.com/VermicFinTech/aeron-prometheus-stat"
LABEL org.opencontainers.image.created=$IMAGE_DATE
LABEL org.opencontainers.image.version=$IMAGE_VERSION
LABEL org.opencontainers.image.title="vermiculus-aeron-prometheus-stats"
LABEL org.opencontainers.image.description="Tool for exporting Aeron stats to Prometheus"

ENTRYPOINT ["/aeron-prometheus-stats/start.sh"]