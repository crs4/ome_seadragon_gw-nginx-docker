#!/usr/bin/env bash

set -e

echo "-- Preparing site configuration file --"
PROTOCOL="${VIRTUAL_PROTO:-http}"

if [ $PROTOCOL == "http" ]; then
    echo "Configuring for HTTP protocol"
    envsubst '${DJANGO_SERVER}' < /etc/nginx/conf.d/ome_seadragon_gw_http.template > /etc/nginx/sites-enabled/ome_seadragon_gw.conf
elif [ $PROTOCOL == "https" ]; then
    echo "Configuring for HTTPS protocol"
    envsubst '${DJANGO_SERVER},${VIRTUAL_HOST}' < /etc/nginx/conf.d/ome_seadragon_gw_https.template > /etc/nginx/sites-enabled/ome_seadragon_gw.conf
else
    echo "${PROTOCOL} is not a valid one"
    exit 125
fi

echo "-- Starting nginx server --"
nginx -g 'daemon off;'
