.PHONY: all
all:
	supervisord -c ./supervisord.conf

.PHONY: on
on:
	systemctl stop NetworkManager
	-killall dnsmasq
	iptables -t nat -F
	iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
	iptables -t nat -A POSTROUTING -o usb0 -j MASQUERADE
	cp *_systemd.network /etc/systemd/network/
	systemctl restart systemd-networkd
	(cd /etc ; rm resolv.conf ; ln -sf ../run/systemd/resolve/resolv.conf resolv.conf)
	sysctl -w net.ipv4.conf.all.forwarding=0
	sysctl -w net.ipv4.conf.all.forwarding=1
	echo "Ok, you can run > make start"

.PHONY: off
off:
	-supervisorctl shutdown
	iptables -t nat -F
	(cd /etc ; rm resolv.conf ; ln -sf ../run/resolvconf/resolv.conf resolv.conf)
	rm /etc/systemd/network/*_systemd.network
	sysctl -w net.ipv4.conf.all.forwarding=0
	systemctl restart systemd-networkd
	systemctl start NetworkManager
