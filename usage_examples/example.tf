module "address_reservation_dhcp_test01"{
  source = "../modules/dhcp-omapi-address-reservation"

  hostname = "dhcp-test01"
  mac =  "08:00:27:dc:bb:87"
  ip = "192.168.50.11"
  omapi_key = var.omapi_key 
  omapi_keyname = var.omapi_keyname 
  omapi_port = var.omapi_port 
  dhcp_server_ip = var.dhcp_server_ip
}
module "address_reservation_dhcp_test02"{
  source = "../modules/dhcp-omapi-address-reservation"

  hostname = "dhcp-test02"
  mac =  "08:00:27:dc:bb:88"
  ip = "192.168.50.12"
  omapi_key = var.omapi_key 
  omapi_keyname = var.omapi_keyname 
  omapi_port = var.omapi_port 
  dhcp_server_ip = var.dhcp_server_ip
}