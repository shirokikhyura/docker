#!/bin/bash

UID_VAR="{{ UID_VALUE }}"
UID_VALUE=$(id -u)
if [ $(id -u) -eq 0 ]; then
    echo "please run docker as your user, current user $USER"
    exit 1
fi

GID_VAR="{{ GID_VALUE }}"
GID_VALUE=$(id -g)
if [ $(id -g) -eq 0 ]; then
    echo "please run docker as your user, current user $USER"
    exit 1
fi

# output
echo ${UID_VAR} = ${UID_VALUE}
echo ${GID_VAR} = ${GID_VALUE}

HOST_IP=$(ip r | awk '/192.168.[0-9]+.0/{print $9}')
echo 'HOST_IP' = ${HOST_IP}

VOLUME_WEB="..\/..\/..\/runner\/public:\/var\/www\/runner\/public"
VOLUME='..\/..\/..\/runner:\/var\/www\/runner:rw'

sed -e "s/${UID_VAR}/${UID_VALUE}/g" \
    -e "s/${GID_VAR}/${GID_VALUE}/g" \
    -e "s/{{ VOLUME_WEB }}/${VOLUME_WEB}/g" \
    -e "s/{{ VOLUME }}/${VOLUME}/g" \
    -e "s/{{ HOST_IP }}/${HOST_IP}/g" \
    < docker-compose-template.yml \
    > docker-compose.yml

cp .env.dist .env

docker-compose up -d --build

echo "done"
