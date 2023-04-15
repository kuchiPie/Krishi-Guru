import requests

def realtime(lat, lon):

    api_key = 'd92bda7a25e6494591e164815231404'
    # lat = 37.7749
    # lon = -122.4194
    url = f'https://api.weatherapi.com/v1/current.json?key={api_key}&q={lat},{lon}'

    response = requests.get(url)
    data = response.json()

    location = data['location']['name']
    country = data['location']['country']
    temp_c = data['current']['temp_c']
    description = data['current']['condition']['text']

    print(f"Current weather in {location}, {country}: {temp_c}°C, {description}")

    return data
