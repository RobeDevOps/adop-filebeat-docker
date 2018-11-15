#!/bin/sh
set -e

if [ "$1" = 'start' ]; then

    getRunningContainers() {
    curl --no-buffer -s -XGET --unix-socket /tmp/docker.sock http:/containers/json | python -c "
    import json, sys
    containers=json.loads(sys.stdin.readline())
    for container in containers:
        print(container)
    "
    }

    ${FILEBEAT_HOME}/filebeat -e -v &
    while true; do
        CONTAINERS=`getRunningContainers`
        echo "$CONTAINERS\n"
        sleep 5
    done
else
  exec "$@"
fi