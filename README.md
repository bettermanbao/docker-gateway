# docker-gateway

docker network create -d macvlan --subnet=192.168.2.0/24 --gateway=192.168.2.1 -o parent=eth0 macnet

docker run -d \\ \
  --name gateway \\ \
  --network macnet \\ \
  --ip 192.168.2.2 \\ \
  --privileged \\ \
  bettermanbao/docker-gateway:aarch64 address port method password

## Supported method:
aes-256-cfb

aes-128-cfb

chacha20

chacha20-ietf

aes-256-gcm

aes-128-gcm

chacha20-poly1305/chacha20-ietf-poly1305

