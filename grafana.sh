#!/bin/sh

export MAX_OPEN_FILES=10000

/usr/sbin/grafana-server \
  --config=/etc/grafana/grafana.ini \
  --homepath=/usr/share/grafana \
  cfg:default.paths.data=/var/lib/grafana \
  cfg:default.paths.logs=/var/log/grafana &

GRAPHITE_URL=${GRAPHITE_URL:-http://graphite:8080/}

sleep 5

curl 'http://admin:admin@localhost:3000/api/datasources' -X POST -H 'Content-Type: application/json;charset=UTF-8' \
  --data-binary '{"name":"graphite","type":"graphite","url":"'$GRAPHITE_URL'","access":"proxy","isDefault":true,"database":null}'

wait

#GRAFANA_USER=grafana
#GRAFANA_GROUP=grafana
#GRAFANA_HOME=/usr/share/grafana
#CONF_DIR=/etc/grafana
#WORK_DIR=$GRAFANA_HOME
#DATA_DIR=/var/lib/grafana
#LOG_DIR=/var/log/grafana
#CONF_FILE=$CONF_DIR/grafana.ini
#MAX_OPEN_FILES=10000
#PID_FILE=/var/run/$NAME.pid
#DAEMON=/usr/sbin/$NAME
#--pidfile=${PID_FILE} --config=${CONF_FILE} cfg:default.paths.data=${DATA_DIR} cfg:default.paths.logs=${LOG_DIR}
#su -s /bin/sh -c "nohup ${DAEMON} ${DAEMON_OPTS} >> /dev/null 3>&1 &" $GRAFANA_USER 2> /dev/null
#return=$?
