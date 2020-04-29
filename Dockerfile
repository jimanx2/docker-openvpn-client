FROM dockage/alpine:3.11-openrc

RUN apk update && apk upgrade && apk add --no-cache openvpn dropbear openssh-client alpine-conf

COPY ./openvpn.rc /etc/init.d/openvpn-client
COPY ./socks5.rc  /etc/init.d/socks5

RUN chmod +x /etc/init.d/* && \
    ssh-keygen -f /root/.ssh/id_ecdsa -t ecdsa -N '' && \
    cat ~/.ssh/id_ecdsa.pub >> ~/.ssh/authorized_keys && \
    chmod og-wx ~/.ssh/authorized_keys && \
    rc-update add openvpn-client && \
    rc-update add dropbear && \
    rc-update add socks5

COPY ./target.ovpn /openvpn/remote.ovpn
COPY ./target-pass.txt /openvpn/remote-pass.txt

EXPOSE 22
EXPOSE 1337