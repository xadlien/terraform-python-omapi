# Terraform Python ISC DHCP SERVER PROVIDER

## Description
This code contains a module to manage isc-dhcp-server address reservations in terraform using a custom python package.

## Setup
1. Clone this repo
2. Copy `modules/dhcp-omapi-address-reservation` to wherever you need the module
3. On the machine you are running terraform be sure to run make install-python in this repo directory. This will install the python package console scripts required by the custom provider setup.

## Examples
See `usage_examples`.