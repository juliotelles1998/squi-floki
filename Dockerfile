FROM ubuntu:focal

ENV TZ=Etc/UTC
LABEL maintainer="Ubuntu Server team <ubuntu-server@lists.ubuntu.com>"

RUN set -eux; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        tzdata wget; \
    echo "Etc/UTC" > /etc/timezone; \
    dpkg-reconfigure -f noninteractive tzdata; \
    DEBIAN_FRONTEND=noninteractive apt-get full-upgrade -y; \
    apt-get install -y --no-install-recommends \
        squid ca-certificates; \
    apt-get autoremove -y; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    mkdir -p /etc/squid/conf.d; \
    echo "include /etc/squid/conf.d/*.conf" >> /etc/squid/squid.conf; \
    chmod -R 644 /etc/squid/conf.d; \
    /usr/sbin/squid -k parse; \
    /usr/sbin/squid --version;

# Baixa o arquivo permitidos.txt atualizado do GitHub
RUN wget -O /etc/squid/permitidos.txt https://raw.githubusercontent.com/juliotelles1998/squi-floki/main/permitidos.txt

# Gera as ACLs com base no arquivo de domínios
RUN set -eux; \
    echo 'acl permitido dstdomain "/etc/squid/permitidos.txt"' >> /etc/squid/conf.d/debian.conf; \
    echo 'http_access allow permitido' >> /etc/squid/conf.d/debian.conf; \
    echo 'http_access deny all' >> /etc/squid/conf.d/debian.conf;

EXPOSE 3128
VOLUME /var/log/squid \
    /var/spool/squid

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["-f", "/etc/squid/squid.conf", "-NYC"]
