# Usage:

## create config.json file in "/path/to/config"
```
{
    "server": "server address",
    "server_port": port,
    "password": "password",
    "method": "method",
    "obfs": "obfs",
    "obfs_param": "obfs_param",
    "protocol": "protocol",
    "protocol_param": "protocol_param"
}
```

## launch gateway container
```
docker network create -d macvlan --subnet=192.168.2.0/24 --gateway=192.168.2.1 -o parent=eth0 macnet

docker run -d --name gateway \
    --network macnet --ip 192.168.2.2 \
    --privileged \
    --restart always \
    -v /path/to/config:/root \
    bettermanbao/docker-gateway:aarch64-0.0.2
```

## Setup client
Change 'default gateway' and 'dns server' to 192.168.2.2.

