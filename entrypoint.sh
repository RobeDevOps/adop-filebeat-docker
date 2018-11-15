#!/bin/sh
set -e

if [ "$1" = 'start' ]; then

    mkdir -p ${LOGS_PATH}

    getRunningContainers() {
    curl --no-buffer -s -XGET --unix-socket /tmp/docker.sock http:/containers/json | python -c "
import json, sys, datetime
containers=json.loads(sys.stdin.readline())
for container in containers:
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d-%H-%M-%S')
    logs_path = '${LOGS_PATH}' + timestamp + '.json'
    with open(logs_path, 'a+') as logfile:
        json.dump(container, logfile)
        logfile.write('\n')
        logfile.close()
"
}

    cd ${FILEBEAT_HOME}
    ./filebeat -e -c filebeat.yml &
    while true; do
        getRunningContainers
        sleep 10
    done
else
  exec "$@"
fi