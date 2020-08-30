FROM centos:centos8

ARG GRAFANA_VER=7.1.5
ARG PROMETHEUS_VER=2.20.1

WORKDIR /usr/local/src
RUN GRAFANA_PACKAGE=grafana-${GRAFANA_VER}-1.x86_64.rpm && \
	curl https://dl.grafana.com/oss/release/${GRAFANA_PACKAGE} -O && \
	dnf install ${GRAFANA_PACKAGE} -y && \
	service grafana-server start && chkconfig --add grafana-server

RUN rm *.rpm

WORKDIR /root
