import json
import time
from urllib import request

_vehicle_to_track = '1602'
_time_between_queries_seconds = '120'
_json_file = 'C:/Important Files/Code Projects/marta-hackathon/src/vehicle_data.json'


def get_bus_location(vehicle_id):
    """
    Get current location data for a vehicle, by vehicle ID
    :param vehicle_id: ID of vehicle to gather data for
    :return: vehcile location
    """
    url = 'http://developer.itsmarta.com/BRDRestService/BRDRestService.svc/'
    query = 'GetAllBus'

    # Formulate URL request and format response as json object
    response = request.urlopen(url + query, timeout=30)
    buses = json.loads(response.read().decode('utf-8'))

    vehicle_data = [bus for bus in buses if bus.get('VEHICLE') == vehicle_id]

    last_query_time = vehicle_data[0].get('MSGTIME')
    print('Vehicle last updated at', last_query_time)

    keys = ['LATITUDE',
            'LONGITUDE',
            'VEHICLE',
            'DIRECTION']

    temp_dict = {}
    for k, v in vehicle_data[0].items():
        if k in keys:
            temp_dict[k] = v

    return {last_query_time: temp_dict}


def append_to_json_file(json_obj, json_file):
    """
    Append json_string to a file
    :param json_obj: json object to append to the file
    :param json_file: fully qualified name of file to append to
    :return: None
    """
    try:
        with open(json_file, 'r') as f_in:
            temp = json.load(f_in)
    except json.JSONDecodeError:
        temp = {}

    temp.update(json_obj)

    with open(json_file, 'w') as f_out:
        json.dump(temp, f_out)


def main():
    while True:
        loc = get_bus_location(vehicle_id=str(_vehicle_to_track))
        append_to_json_file(json_obj=loc, json_file=_json_file)
        time.sleep(int(_time_between_queries_seconds))

if __name__ == '__main__':
    main()
