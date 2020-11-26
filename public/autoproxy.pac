function FindProxyForURL(url, host) {

    // use proxy for specific domains
    if (shExpMatch(host, "*.merchant.razer.com|*.molpay.com|18.139.241.70|*2005655089.ap-southeast-1.elb.amazonaws.com"))
        return "SOCKS localhost:1337";

    // by default use no proxy
    return "DIRECT";
}
