FROM dockage/alpine:3.11-openrc

RUN apk add --update openvpn dropbear openssh-client expect build-base autoconf nodejs npm && \
    wget https://www.kraxel.org/releases/webfs/webfs-1.21.tar.gz && tar xvzf webfs-1.21.tar.gz && \
    cd webfs-1.21 && \
    make && make install && \
    apk del build-base autoconf

COPY ./hpts.rc      /etc/init.d/hpts
COPY ./openvpn.rc   /etc/init.d/openvpn-client
COPY ./socks5.rc    /etc/init.d/socks5
COPY ./awebfsd.rc    /etc/init.d/awebfsd
COPY ./public       /var/www
COPY ./mime.types   /etc/mime.types

RUN chmod +x /etc/init.d/* && \
    ssh-keygen -f /root/.ssh/id_ecdsa -t ecdsa -N '' && \
    cat ~/.ssh/id_ecdsa.pub >> ~/.ssh/authorized_keys && \
    chmod og-wx ~/.ssh/authorized_keys && \
    rc-update add openvpn-client && \
    rc-update add dropbear && \
    rc-update add socks5 && \
    rc-update add awebfsd

COPY ./target.ovpn /openvpn/remote.ovpn
COPY ./target-pass.txt /openvpn/remote-pass.txt

EXPOSE 22
EXPOSE 1337
EXPOSE 1338
