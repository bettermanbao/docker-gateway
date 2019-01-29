FROM balenalib/aarch64-alpine

COPY init.sh /
COPY ssr-local /
COPY ssr-redir /
COPY dns-forwarder /

RUN ["cross-build-start"]
RUN chmod +x /init.sh
RUN chmod +x /ssr-local
RUN chmod +x /ssr-redir
RUN chmod +x /dns-forwarder

RUN echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/01-ip_forward.conf

RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add iptables pcre openssl dnsmasq ipset && \
    rm -rf /tmp/*

RUN ["cross-build-end"]

COPY dnsmasq.conf /etc/
COPY accelerated-domains.china.conf /etc/dnsmasq.d/
COPY chnlist.ipset /

ENTRYPOINT ["/init.sh"]
