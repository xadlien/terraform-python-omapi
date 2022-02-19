terraform {
  required_providers {
    custom = {
      source = "nazarewk-iac/custom"
      version = "0.3.0"
    }
  }
}
provider "custom" {
  input = <<JSON
{
    "dhcp_server_ip": "${var.dhcp_server_ip}",
    "omapi_port": ${var.omapi_port},
    "omapi_keyname": "${var.omapi_keyname}",
    "omapi_key": "${var.omapi_key}"
}
JSON
}
resource "custom_resource" "dhcp-test01" {
  input = <<JSON
{
    "type": "address_reservation",
    "hostname": "dhcp-test01",
    "mac": "08:00:27:dc:bb:87",
    "ip": "192.168.50.11"
}
JSON

  program_create = ["python3", "./python-omapi-provider.py", "create"]
  program_read = ["python3", "./python-omapi-provider.py", "read"]
  program_update = ["python3", "./python-omapi-provider.py", "update"]
  program_delete = ["python3", "./python-omapi-provider.py", "delete"]
}

resource "custom_resource" "dhcp-test02" {
  input = <<JSON
{
    "type": "address_reservation",
    "hostname": "dhcp-test02",
    "mac": "08:00:27:dc:bb:88",
    "ip": "192.168.50.12"
}
JSON

  program_create = ["python3", "./python-omapi-provider.py", "create"]
  program_read = ["python3", "./python-omapi-provider.py", "read"]
  program_update = ["python3", "./python-omapi-provider.py", "update"]
  program_delete = ["python3", "./python-omapi-provider.py", "delete"]
}