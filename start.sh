#!/bin/bash

service grafana-server start
prometheus --config.file=prometheus.yml
