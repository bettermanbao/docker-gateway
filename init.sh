#!/bin/sh

# init.sh address port method password

sed -i s/\"address\":\"address\",/\"address\":\"$1\",/ /v2ray/config.json
sed -i s/\"port\":port,/\"port\":$2,/ /v2ray/config.json
sed -i s/\"method\":\"method\",/\"method\":\"$3\",/ /v2ray/config.json
sed -i s/\"password\":\"password\",/\"password\":\"$4\",/ /v2ray/config.json

iptables -t nat -I PREROUTING -p tcp ! -d $(ifconfig eth0 | awk '/inet addr/{print substr($2,6)}') -j REDIRECT --to-port 1081

/v2ray/v2ray
