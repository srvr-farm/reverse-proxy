
.PHONY: install

install:
	mkdir -p /srv/reverse-proxy/html /srv/reverse-proxy/conf.d /opt/reverse-proxy/bin
	cp -R service/srv/reverse-proxy/conf.d/* /srv/reverse-proxy/conf.d
	cp -R service/opt/reverse-proxy/bin/* /opt/reverse-proxy/bin
	chmod +x /opt/reverse-proxy/bin/*
	cp service/usr/lib/systemd/system/reverse-proxy.service /usr/lib/systemd/system/
	systemctl daemon-reload
	systemd-analyze verify /usr/lib/systemd/system/reverse-proxy.service && sudo systemctl enable reverse-proxy.service && systemctl restart reverse-proxy.service


