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
resource "custom_resource" "this" {
  input = <<JSON
{
    "hostname": "${var.hostname}",
    "mac": "${var.mac}",
    "ip": "${var.ip}"
}
JSON

  program_create = ["python-omapi-provider", "create"]
  program_read = ["python-omapi-provider", "read"]
  program_update = ["python-omapi-provider", "update"]
  program_delete = ["python-omapi-provider", "delete"]
}