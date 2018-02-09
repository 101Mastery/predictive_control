
json = webread('http://api.wunderground.com/api/Your_Key/history_20060405/q/CA/San_Francisco.json')

data = jsondecode(json)