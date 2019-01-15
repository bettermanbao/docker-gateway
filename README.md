# Usage:

docker network create -d macvlan --subnet=192.168.2.0/24 --gateway=192.168.2.1 -o parent=eth0 macnet

docker run -d --name gateway --network macnet --ip 192.168.2.2 --privileged  -v /path/to/config:/root bettermanbao/docker-gateway:aarch64-0.0.1

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
    "protocol_param": "protocol_param",
    "local_address": "0.0.0.0",
    "local_port": 1080,
    "timeout": 300,
    "workers": 1
}
```
