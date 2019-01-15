#!/bin/sh

echo "nameserver 114.114.114.114" > /etc/resolv.conf
iptables -t nat -I PREROUTING -p tcp ! -d $(ifconfig eth0 | awk '/inet addr/{print substr($2,6)}') -j REDIRECT --to-port 1081

/ssr-local -c /root/config.json -u  > /dev/null 2>&1 &
/v2ray/v2ray > /dev/null 2>&1
