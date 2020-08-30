FROM centos:centos8

ARG GRAFANA_VER=7.1.5
ARG PROMETHEUS_VER=2.20.1

WORKDIR /usr/local/src
RUN GRAFANA_PACKAGE=grafana-${GRAFANA_VER}-1.x86_64.rpm && \
	curl https://dl.grafana.com/oss/release/${GRAFANA_PACKAGE} -O && \
	dnf install ${GRAFANA_PACKAGE} -y && \
	chkconfig --add grafana-server
RUN curl https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VER}/prometheus-${PROMETHEUS_VER}.linux-amd64.tar.gz -OL && \
	tar xvfz prometheus-${PROMETHEUS_VER}.linux-amd64.tar.gz && \
	ln -s /usr/local/src/prometheus-${PROMETHEUS_VER}.linux-amd64/prometheus /usr/bin/prometheus

RUN rm *.rpm *.tar.gz

WORKDIR /root
COPY start.sh .
RUN cp /usr/local/src/prometheus-${PROMETHEUS_VER}.linux-amd64/prometheus.yml .

CMD [ "/bin/bash", "start.sh" ]
