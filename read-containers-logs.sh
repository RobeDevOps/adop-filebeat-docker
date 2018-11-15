#!/bin/bash


getRunContainers(){
curl --no-buffer -s -XGET --unix-socket /var/run/docker.sock http:/containers/json | python -c "
import json, sys
containers=json.loads(sys.stdin.readline())
for container in containers:
    print(container['Id'])
"
}

getContainerName(){
curl --no-buffer -s -XGET --unix-socket /var/run/docker.sock http:/containers/$1/json | python -c "
import json, sys
container=json.loads(sys.stdin.readline())
print(container['Name'])
" | sed 's;/;;'
}

CONTAINERS=`getRunContainers`
for CONTAINER in $CONTAINERS; do
  echo `getContainerName $CONTAINER`
done