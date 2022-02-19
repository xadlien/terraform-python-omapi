provider "multiverse" {}

resource "multiverse_custom_resource" "spotinst_targetset_and_rules" {
  executor = "python3"
  script = "python-omapi-provider.py"
  id_key = "hostname"
  data = <<JSON
{
    "type": "address_reservation",
    "dhcp_server_ip": "192.168.50.10",
    "omapi_port": 7911,
    "omapi_keyname": "omapi_key",
    "omapi_key": "3saYClvPIcsOBzW/74/Z4Q==",
    "hostname": "dhcp-test01",
    "mac": "08:00:27:dc:bb:87",
    "ip": "192.168.50.11"
}
JSON
}