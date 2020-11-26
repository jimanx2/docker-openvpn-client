Your VPN is slow and you can't access outside world while in VPN?

This is a docker container to isolate your VPN connection so you can freely have conference call and access your intranet at the same time.

![sample screenshot](https://github.com/jimanx2/docker-openvpn-client/raw/master/screenshot.png)

# Requirements

1. You need docker engine installed
2. Your VPN profile (.ovpn, single file with certs)
3. Your VPN must use cert passphrase only (not username/password)

# How to build & use

1. edit target.ovpn to have same content as your .ovpn profile, add this line: `askpass /openvpn/remote-pass.txt`
2. edit target-pass.txt and put your ovpn passphrase
3. build the container: `docker build -t <yourimagename> .`
4. run the container: `docker run -d -p 1337:1337 -p 1338:1338 --restart=always --name=vpnclient --cap-add NET_ADMIN <yourimagename>`
4.1 edit public/autoproxy.pac and specify which domain you want to go through the VPN
5. set your browser proxy (&bull;) to SOCKS5: `localhost:1337`
6. open your browser and try to visit your intranet
* i recommend firefox for this as it does not modify system proxy

# FAQ

1. Q: What if my VPN have timeout disconnect? A: just run `docker restart vpnclient` to reconnect
2. Q: What if my my VPN use username/password/mfa? A: you can modify `openvpn.rc` script to use [expect](https://linux.die.net/man/1/expect) script
3. Q: How to use Git with this proxy? A: `git config http.proxy 'socks5://127.0.0.1:1337'`
4. Q: What about terminal? ssh? A: use [tsocks](https://sourceforge.net/projects/tsocks/) `tsocks ssh myinternalhost`
