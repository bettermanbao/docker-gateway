#!/bin/sh

# init.sh address port method password

sed -i s/\"address\":\"address\",/\"address\":\"$1\",/ /v2ray/config.json
sed -i s/\"port\":port,/\"port\":$2,/ /v2ray/config.json
sed -i s/\"method\":\"method\",/\"method\":\"$3\",/ /v2ray/config.json
sed -i s/\"password\":\"password\",/\"password\":\"$4\",/ /v2ray/config.json

/v2ray
