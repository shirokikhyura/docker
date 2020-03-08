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

VOLUME_WEB="..\/..\/..\/runner\/public:\/var\/www\/runner\/public"
VOLUME='..\/..\/..\/runner:\/var\/www\/runner:rw'

sed -e "s/${UID_VAR}/${UID_VALUE}/g" \
    -e "s/${GID_VAR}/${GID_VALUE}/g" \
    -e "s/{{ VOLUME_WEB }}/${VOLUME_WEB}/g" \
    -e "s/{{ VOLUME }}/${VOLUME}/g" \
    < docker-compose-template.yml \
    > docker-compose.yml

docker-compose up -d --build

echo "done"
