# Terraform Python ISC DHCP SERVER PROVIDER

## Description
This code contains a module to manage isc-dhcp-server address reservations in terraform using a custom python package.

## Setup
1. Clone this repo
2. Copy `modules/dhcp-omapi-address-reservation` to wherever you need the module
3. On the machine you are running terraform be sure to run make install-python in this repo directory. This will install the python package console scripts required by the custom provider setup.

## Examples
See `usage_examples`.

## Setting up OMAPI 
### Generating a Key
The easiest way I found to generate a key for OMAPI is the following command:
```bash
dd if=/dev/urandom bs=16 count=1 2>/dev/null | openssl enc -e -base64
```
**Note that this is insecure** and you should use:
```bash
/usr/sbin/dnssec-keygen -a RSASHA256  omapi
```
Then use the key file created. You will see a base64 key in the file. Copy that for the next step.

### Settings For ISC DHCP Server
In the file `/etc/dhcp/dhcpd.conf` add the following:
```
omapi-port 7911;
omapi-key omapi_key;

key omapi_key {
        algorithm hmac-md5;
        secret yourkeyhere;
}
```

If you use the insecure method the algorithm is hmac-md5. Otherwise it is rsasha256.