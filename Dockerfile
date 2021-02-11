# Builder (stage 0)
ARG OME_SEADRAGON_GW_VERSION=0.2.0

FROM crs4/ome_seadragon_gw-web:${OME_SEADRAGON_GW_VERSION}

RUN python manage.py collectstatic --noinput

# Production
FROM nginx:1.15.11
LABEL maintainer="luca.lianas@crs4.it"

COPY --from=0 /home/ome-seadragon/app/ome_seadragon_gateway/static/ /opt/ome_seadragon_gw/nginx/static/

RUN mkdir /etc/nginx/sites-enabled/

COPY conf_files/nginx.conf /etc/nginx/nginx.conf
COPY conf_files/*.template /etc/nginx/conf.d/
COPY conf_files/ome_seadragon_gw.location /etc/nginx/apps/
COPY resources/wait-for-it.sh \
     resources/entrypoint.sh \
     /usr/local/bin/

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
