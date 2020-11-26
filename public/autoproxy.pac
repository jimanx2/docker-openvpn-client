function FindProxyForURL(url, host) {

    // use proxy for specific domains
    if (shExpMatch(host, "*"))
        return "SOCKS localhost:1337";

    // by default use no proxy
    return "DIRECT";
}
