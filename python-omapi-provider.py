import sys
import json
import pypureomapi

class AddressReservation:

    def __init__(self, hostname, mac, ip):
        self.hostname = hostname 
        self.mac = mac
        self.ip = ip

    def to_dict(self):
        return {
            "hostname": self.hostname,
            "mac": self.mac,
            "ip": self.ip
        }

class IscDhcpServer:

    # initialize connection to the dhcp server
    def __init__(self, server_ip, server_port, keyname, key):
        self.server_ip = server_ip
        self.server_port = server_port 
        self.keyname = keyname
        self.key = key 
        self.omapi = pypureomapi.Omapi(
            self.server_ip, 
            self.server_port, 
            bytearray(self.keyname, "ascii"), 
            bytearray(self.key, "ascii"))
    
    # create an object
    # filter object types to correct functions
    def create(self, obj):
        if type(obj) == AddressReservation:
            return self.create_address_reservation(obj)

    def create_address_reservation(self, ar):
        # check to make sure the host doesn't exist
        try:
            check_val = self.omapi.lookup_host(ar.hostname)
            print(f"ERROR: {ar.hostname} already reserved")
            #return check_val 
            exit(1)
        except pypureomapi.OmapiErrorNotFound:
            self.omapi.add_host_supersede_name(ar.ip, ar.mac, ar.hostname)
            return ar.to_dict()

    # filter based on object type
    def read(self, obj):
        if type(obj) == AddressReservation:
            return self.read_address_reservation(obj)

    def read_address_reservation(self, ar):
        try:
            return_data = self.omapi.lookup_host(ar.hostname)
            return return_data
        except pypureomapi.OmapiErrorNotFound:
            exit(1)

    # filter based on object type
    def update(self, obj):
        if type(obj) == AddressReservation:
            return self.update_address_reservation(obj)

    def update_address_reservation(self, ar):
        try:
            return_data = self.omapi.lookup_host(ar.hostname)
            need_update = False
            if ar.ip != return_data['ip']:
                need_update = True 
            elif ar.mac != return_data['mac']:
                need_update = True 
            
            # if an update is needed update the host
            if need_update:
                self.omapi.del_host(return_data['mac'])
                self.create_address_reservation(ar)
            
            return ar.to_dict()

        except pypureomapi.OmapiErrorNotFound:
            print(f'ERROR: {ar.hostname} not found')
            exit(1)

    # filter based on object type
    def delete(self, obj):
        if type(obj) == AddressReservation:
            return self.delete_address_reservation(obj)

    def delete_address_reservation(self, ar):
        try:
            return_data = self.omapi.lookup_host(ar.hostname)
            self.omapi.del_host(return_data['mac'])
            
            return None

        except pypureomapi.OmapiErrorNotFound:
            print(f'ERROR: {ar.hostname} not found')
            exit(1)



def handler(event, data):
    # parse input json data
    # create dhcp server connection
    data_as_json = json.loads(data)
    dhcp_server = IscDhcpServer(
        data_as_json['dhcp_server_ip'], 
        data_as_json['omapi_port'], 
        data_as_json['omapi_keyname'], 
        data_as_json['omapi_key'])

    # Create object to operate on
    if data_as_json['type'] == "address_reservation":
        ar = AddressReservation(
            data_as_json['hostname'], 
            data_as_json['mac'], 
            data_as_json['ip'])


    if event == "create":
        return dhcp_server.create(ar)
            
    elif event == "read":
        return dhcp_server.read(ar)
            
    elif event == "update":
        return dhcp_server.update(ar)
            
    elif event == "delete":
        return dhcp_server.delete(ar)
   
def read_data():
    data = ''
    for line in sys.stdin:
        data += line

    return data
   
if __name__ == '__main__':
    context = read_data()
    print(json.dumps(handler(sys.argv[1], context)))