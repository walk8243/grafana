FROM centos:centos8

WORKDIR /usr/local/src

ARG GRAFANA_VER=7.1.5
RUN GRAFANA_PACKAGE=grafana-${GRAFANA_VER}-1.x86_64.rpm && \
	curl https://dl.grafana.com/oss/release/${GRAFANA_PACKAGE} -O && \
	dnf install ${GRAFANA_PACKAGE} -y && \
	chkconfig --add grafana-server

ARG PROMETHEUS_VER=2.20.1
RUN curl https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VER}/prometheus-${PROMETHEUS_VER}.linux-amd64.tar.gz -OL && \
	tar xvfz prometheus-${PROMETHEUS_VER}.linux-amd64.tar.gz && \
	ln -s /usr/local/src/prometheus-${PROMETHEUS_VER}.linux-amd64/prometheus /usr/bin/prometheus

ARG TELEGRAF_VER=1.15.2
RUN TELEGRAF_PACKAGE=telegraf-${TELEGRAF_VER}-1.x86_64.rpm && \
	curl https://dl.influxdata.com/telegraf/releases/${TELEGRAF_PACKAGE} -OL && \
	dnf install ${TELEGRAF_PACKAGE} -y && \
	chkconfig --add telegraf && \
	cp /etc/telegraf/telegraf.conf /etc/telegraf/telegraf.conf.bk

RUN rm *.rpm *.tar.gz

WORKDIR /root
COPY start.sh .
COPY grafana-datasource.yaml /etc/grafana/provisioning/datasources/prometheus.yaml
COPY prometheus.yml .
COPY telegraf.conf /etc/telegraf/telegraf.conf

CMD [ "/bin/bash", "start.sh" ]
