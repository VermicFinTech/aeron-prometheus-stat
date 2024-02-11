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

# OpenJDK13 not available for alpine linux > 3.18 as of 1 feb 2024
FROM alpine:3.18

RUN apk add bash git openjdk13

COPY . /aeron-prometheus-stats/

RUN mkdir -p /opt/aeron-prometheus-stats/lib
RUN ls /aeron-prometheus-stats/
RUN dos2unix /aeron-prometheus-stats/gradlew
RUN cd  /aeron-prometheus-stats/ && ./gradlew fatJar
RUN cp /aeron-prometheus-stats/build/libs/aeron-prometheus-stats-all-1.0-SNAPSHOT.jar /opt/aeron-prometheus-stats/lib
