#!/bin/sh

echo "nameserver 114.114.114.114" > /etc/resolv.conf

iptables -t nat -I PREROUTING -p tcp ! -d $(ifconfig eth0 | awk '/inet addr/{print substr($2,6)}') -j REDIRECT --to-port 1081

ip rule add fwmark 1 table 100
ip route add local 0.0.0.0/0 dev lo table 100
iptables -t mangle -I PREROUTING -p udp ! -d $(ifconfig eth0 | awk '/inet addr/{print substr($2,6)}') -j TPROXY --on-port 1081 --tproxy-mark 1

/ssr-local -c /root/config.json -u  > /dev/null 2>&1 &
/v2ray/v2ray > /dev/null 2>&1
