#!/bin/bash

service grafana-server start
prometheus --config.file=prometheus.yml &
service telegraf start

while true;
do
	sleep 10;
done
