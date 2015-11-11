.PHONY: all
all:

.PHONY: on
on:
	systemctl stop NetworkManager
	cp *_systemd.network /etc/systemd/network/
	systemctl restart systemd-networkd
	(cd /etc ; rm resolv.conf ; ln -sf ../run/systemd/resolve/resolv.conf resolv.conf)
	iptables -t nat -F
	iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
	sysctl -w net.ipv4.conf.all.forwarding=1
	killall dnsmasq
	echo "Ok, you can run: supervisord -c ./supervisord.conf"

.PHONY: off
off:
	@supervisorctl shutdown
	sysctl -w net.ipv4.conf.all.forwarding=0
	iptables -t nat -F
	(cd /etc ; rm resolv.conf ; ln -sf ../run/resolvconf/resolv.conf resolv.conf)
	rm /etc/systemd/network/*_systemd.network
	systemctl restart systemd-networkd
	systemctl start NetworkManager
