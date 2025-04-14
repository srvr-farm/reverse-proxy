
.PHONY: install docker

install:
	mkdir -p /opt/reverse-proxy/bin ;
	cp -R service/opt/reverse-proxy/bin/* /opt/reverse-proxy/bin ;
	chmod +x /opt/reverse-proxy/bin/*
	cp service/usr/lib/systemd/system/reverse-proxy.service /usr/lib/systemd/system/
	systemctl daemon-reload
	systemd-analyze verify /usr/lib/systemd/system/reverse-proxy.service && sudo systemctl enable reverse-proxy.service && systemctl restart reverse-proxy.service

docker:
	mkdir -p target ;
	cp -R service/* ./target/ ;
	cp docker/Dockerfile ./target/ ;
	cd target ; docker build -t registry.srvr.farm/reverse-proxy:latest . ;

docker-push:
	docker push registry.srvr.farm/reverse-proxy:latest ;

