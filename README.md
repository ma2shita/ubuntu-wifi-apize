Wi-Fi APize for Ubuntu 15.04
============================

Using hostapd(Wi-Fi Authenticator), dnsmasq(DHCPd, DNSd) and Supervisord(Process Control)

Operation;
----------

- `sudo make on`
- `sudo make off`

Install Libraries;
------------------

```
$ curl -kL https://raw.github.com/pypa/pip/master/contrib/get-pip.py | sudo python
$ sudo pip install supervisor
$ sudo apt-get install -y hostapd
$ git clone THIS
```

LICENSE;
--------

MIT

EOT
