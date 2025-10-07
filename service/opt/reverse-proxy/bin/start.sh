#!/usr/bin/env bash


mkdir -p /srv/reverse-proxy/certs
cp /etc/letsencrypt/live/srvr.farm-0001/fullchain.pem /srv/reverse-proxy/certs/
cp /etc/letsencrypt/live/srvr.farm-0001/privkey.pem /srv/reverse-proxy/certs/

docker network create -d bridge reverse-proxy-net

docker container rm -f reverse-proxy 2>/dev/null || true;
docker run --rm \
	--net reverse-proxy-net \
	--name reverse-proxy \
	-p 10.0.0.10:443:443 \
	-p 10.0.0.10:80:80 \
	-p 10.0.0.10:25565:25565 \
	--volume /srv/reverse-proxy/certs:/etc/nginx/certs:ro \
	registry.srvr.farm/reverse-proxy:latest ;

