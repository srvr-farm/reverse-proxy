#!/usr/bin/env bash


mkdir -p /srv/reverse-proxy/certs
test -f /srv/reverse-proxy/certs/fullchain.pem || cp /etc/letsencrypt/live/srvr.farm/fullchain.pem /srv/reverse-proxy/certs/
test -f /srv/reverse-proxy/certs/privkey.pem || cp /etc/letsencrypt/live/srvr.farm/privkey.pem /srv/reverse-proxy/certs/

docker network create -d bridge reverse-proxy-net

docker pull nginx:latest
docker container rm -f reverse-proxy 2>/dev/null || true;
docker run --rm \
	--net reverse-proxy-net \
	--name reverse-proxy \
	-p 10.0.0.10:443:443 \
	--volume /srv/reverse-proxy/conf.d:/etc/nginx/conf.d:ro \
	--volume /srv/reverse-proxy/certs:/etc/nginx/certs:ro \
	nginx:latest ;

