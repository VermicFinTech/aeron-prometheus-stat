#!/bin/bash
./aeron-prometheus-stats/consul agent -join 172.19.0.4 -data-dir /tmp/consul -client 0.0.0.0 > /tmp/consul.log 2>&1 &
java -cp /opt/aeron-prometheus-stats/lib/aeron-prometheus-stats-all-1.0-SNAPSHOT.jar -Daeron.dir=/dev/shm/aeron-appuser-9999-fix co.fairtide.prometheus_aeron_stat.PrometheusAeronStat -port 50051 -delay 5000