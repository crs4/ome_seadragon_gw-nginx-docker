#!/usr/bin/env bash

set -e

echo "-- Preparing site configuration file --"
envsubst '${DJANGO_SERVER}' < /etc/nginx/conf.d/ome_seadragon_gw.template > /etc/nginx/sites-enabled/ome_seadragon_gw.conf

echo "-- Starting nginx server --"
nginx -g 'daemon off;'
