#!/bin/sh

echo "nameserver 114.114.114.114" > /etc/resolv.conf

iptables -t nat -I PREROUTING -p tcp ! -d $(ifconfig eth0 | awk '/inet addr/{print substr($2,6)}')/16 -j REDIRECT --to-port 1081

ip rule add fwmark 1 lookup 100
ip route add local 0.0.0.0/0 dev lo table 100
iptables -t mangle -N DIVERT
iptables -t mangle -A DIVERT -j MARK --set-mark 1
iptables -t mangle -A DIVERT -j ACCEPT
iptables -t mangle -A PREROUTING -p udp -m socket -j DIVERT
iptables -t mangle -A PREROUTING -p udp ! -d $(ifconfig eth0 | awk '/inet addr/{print substr($2,6)}')/16 -j TPROXY --tproxy-mark 0x1/0x1 --on-port 1081

/ssr-local -c /root/config.json -u  > /dev/null 2>&1 &
/v2ray/v2ray > /dev/null 2>&1
