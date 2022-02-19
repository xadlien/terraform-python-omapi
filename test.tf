terraform {
  required_providers {
    custom = {
      source = "nazarewk-iac/custom"
      version = "0.3.0"
    }
  }
}
provider "custom" {
}
resource "custom_resource" "dhcp-test01" {
  input = <<JSON
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
  state = "managed_state"

  program_create = ["python3", "./python-omapi-provider.py", "create"]
  program_read = ["python3", "./python-omapi-provider.py", "read"]
  program_update = ["python3", "./python-omapi-provider.py", "update"]
  program_delete = ["python3", "./python-omapi-provider.py", "delete"]
}

resource "custom_resource" "dhcp-test02" {
  input = <<JSON
{
    "type": "address_reservation",
    "dhcp_server_ip": "192.168.50.10",
    "omapi_port": 7911,
    "omapi_keyname": "omapi_key",
    "omapi_key": "3saYClvPIcsOBzW/74/Z4Q==",
    "hostname": "dhcp-test02",
    "mac": "08:00:27:dc:bb:88",
    "ip": "192.168.50.12"
}
JSON
  state = "managed_state"

  program_create = ["python3", "./python-omapi-provider.py", "create"]
  program_read = ["python3", "./python-omapi-provider.py", "read"]
  program_update = ["python3", "./python-omapi-provider.py", "update"]
  program_delete = ["python3", "./python-omapi-provider.py", "delete"]
}