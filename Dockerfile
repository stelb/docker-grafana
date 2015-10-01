#FROM centos:7
FROM stelb/base

ENV GRAPHITE_VERSION 2.1.3
ENV GRAPHITE_BUILD 1

#RUN yum -y update && yum -y install https://grafanarel.s3.amazonaws.com/builds/grafana-${GRAPHITE_VERSION}-${GRAPHITE_BUILD}.x86_64.rpm python-setuptools && yum clean all && easy_install supervisor
#RUN /etc/init.d/grafana-server start && curl 'http://admin:admin@localhost:3000/api/datasources' -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"name":"graphite","type":"graphite","url":"http://web/","access":"proxy","isDefault":true,"database":null}' && /etc/init.d/grafana-server stop

RUN yum -y install https://grafanarel.s3.amazonaws.com/builds/grafana-${GRAPHITE_VERSION}-${GRAPHITE_BUILD}.x86_64.rpm

COPY supervisord.conf /etc/supervisord.conf
COPY grafana.sh /grafana.sh

EXPOSE 3000

#CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
